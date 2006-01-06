From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 02:10:41 +0100
Message-ID: <20060106011041.GA23899@isilmar.linta.de>
References: <20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============063645477868427891=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============063645477868427891==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2006 at 04:04:07PM -0800, Patrick Mochel wrote:
> A better point, and one that would actually be useful, would be to remove
> the file altogether. Let Dominik export a power file, with complete
> control over the values, for each pcmcia device. Then you never have to
> worry about breaking PCMCIA again.

Then I'll try to push this into 2.6.16 later on; also I still need to fix
up userspace accordingly...

BTW, ACK on the removal of power/state from me... PCMCIA shouldn't hold this
removal up.

	Dominik


diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 0252582..a4f3258 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -920,6 +920,37 @@ pcmcia_device_stringattr(prod_id2, prod_
 pcmcia_device_stringattr(prod_id3, prod_id[2]);
 pcmcia_device_stringattr(prod_id4, prod_id[3]);
 
+
+static ssize_t pcmcia_show_suspend(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
+
+	if (p_dev->dev.power.power_state.event != PM_EVENT_ON)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t pcmcia_store_suspend(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
+	int ret = 0;
+
+        if (!count)
+                return -EINVAL;
+
+	if (p_dev->dev.power.power_state.event == PM_EVENT_ON)
+		ret = dpm_runtime_suspend(dev, PMSG_SUSPEND);
+	else
+		dpm_runtime_resume(dev);
+
+	return ret ? ret : count;
+
+	return count;
+}
+
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
@@ -945,8 +976,9 @@ static ssize_t pcmcia_store_allow_func_i
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
-        if (!count)
-                return -EINVAL;
+
+	if (!count)
+		return -EINVAL;
 
 	down(&p_dev->socket->skt_sem);
 	p_dev->allow_func_id_match = 1;
@@ -959,6 +991,7 @@ static ssize_t pcmcia_store_allow_func_i
 
 static struct device_attribute pcmcia_dev_attrs[] = {
 	__ATTR(function, 0444, func_show, NULL),
+	__ATTR(suspend, 0644, pcmcia_show_suspend, pcmcia_store_suspend),
 	__ATTR_RO(func_id),
 	__ATTR_RO(manf_id),
 	__ATTR_RO(card_id),
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index 7a77446..df1917c 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -98,6 +98,30 @@ static ssize_t pccard_store_insert(struc
 }
 static CLASS_DEVICE_ATTR(card_insert, 0200, NULL, pccard_store_insert);
 
+
+static ssize_t pccard_show_suspend(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *s = to_socket(dev);
+	return sprintf(buf, "%u\n", s->state & SOCKET_SUSPEND ? 1 : 0);
+}
+
+static ssize_t pccard_store_suspend(struct class_device *dev, const char *buf, size_t count)
+{
+	ssize_t ret;
+	struct pcmcia_socket *s = to_socket(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	if (!(s->state & SOCKET_SUSPEND))
+		ret = pcmcia_suspend_card(s);
+	else
+		ret = pcmcia_resume_card(s);
+
+	return ret ? -ENODEV : count;
+}
+static CLASS_DEVICE_ATTR(card_suspend, 0644, pccard_show_suspend, pccard_store_suspend);
+
 static ssize_t pccard_store_eject(struct class_device *dev, const char *buf, size_t count)
 {
 	ssize_t ret;
@@ -320,6 +344,7 @@ static struct class_device_attribute *pc
 	&class_device_attr_card_vpp,
 	&class_device_attr_card_vcc,
 	&class_device_attr_card_insert,
+	&class_device_attr_card_suspend,
 	&class_device_attr_card_eject,
 	&class_device_attr_card_irq_mask,
 	&class_device_attr_available_resources_setup_done,

--===============063645477868427891==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============063645477868427891==--
