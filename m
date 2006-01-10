From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 2/2] pcmcia fixes for 2.6.15: runtime
	powermanagement interface
Date: Tue, 10 Jan 2006 21:42:18 +0100
Message-ID: <20060110204218.GB24611@dominikbrodowski.de>
References: <20060110204128.GA24611@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============24506758292276709=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060110204128.GA24611@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pcmcia@lists.infradead.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============24506758292276709==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[PATCH] pcmcia: runtime powermanagement interface

With the "power/state" sysfs interface being deprecated, make another
one available which is compatible to what was discussed on the linux
PM mailinglist.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/pcmcia/ds.c           |   37 +++++++++++++++++++++++++++++++++++--
 drivers/pcmcia/socket_sysfs.c |   25 +++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

88605b085b020bfcf08313331f50e754b46866d9
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 0252582..621ec45 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -920,6 +920,37 @@ pcmcia_device_stringattr(prod_id2, prod_
 pcmcia_device_stringattr(prod_id3, prod_id[2]);
 pcmcia_device_stringattr(prod_id4, prod_id[3]);
 
+
+static ssize_t pcmcia_show_pm_state(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
+
+	if (p_dev->dev.power.power_state.event != PM_EVENT_ON)
+		return sprintf(buf, "off\n");
+	else
+		return sprintf(buf, "on\n");
+}
+
+static ssize_t pcmcia_store_pm_state(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
+	int ret = 0;
+
+        if (!count)
+                return -EINVAL;
+
+	if ((p_dev->dev.power.power_state.event == PM_EVENT_ON) &&
+	    (!strncmp(buf, "off", 3)))
+		ret = dpm_runtime_suspend(dev, PMSG_SUSPEND);
+	else if ((p_dev->dev.power.power_state.event != PM_EVENT_ON) &&
+		 (!strncmp(buf, "on", 2)))
+		dpm_runtime_resume(dev);
+
+	return ret ? ret : count;
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
+	__ATTR(pm_state, 0644, pcmcia_show_pm_state, pcmcia_store_pm_state),
 	__ATTR_RO(func_id),
 	__ATTR_RO(manf_id),
 	__ATTR_RO(card_id),
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index 7a77446..5ab1cde 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -98,6 +98,30 @@ static ssize_t pccard_store_insert(struc
 }
 static CLASS_DEVICE_ATTR(card_insert, 0200, NULL, pccard_store_insert);
 
+
+static ssize_t pccard_show_card_pm_state(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *s = to_socket(dev);
+	return sprintf(buf, "%s\n", s->state & SOCKET_SUSPEND ? "off" : "on");
+}
+
+static ssize_t pccard_store_card_pm_state(struct class_device *dev, const char *buf, size_t count)
+{
+	ssize_t ret = -EINVAL;
+	struct pcmcia_socket *s = to_socket(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	if (!(s->state & SOCKET_SUSPEND) && !strncmp(buf, "off", 3))
+		ret = pcmcia_suspend_card(s);
+	else if ((s->state & SOCKET_SUSPEND) && !strncmp(buf, "on", 2))
+		ret = pcmcia_resume_card(s);
+
+	return ret ? -ENODEV : count;
+}
+static CLASS_DEVICE_ATTR(card_pm_state, 0644, pccard_show_card_pm_state, pccard_store_card_pm_state);
+
 static ssize_t pccard_store_eject(struct class_device *dev, const char *buf, size_t count)
 {
 	ssize_t ret;
@@ -320,6 +344,7 @@ static struct class_device_attribute *pc
 	&class_device_attr_card_vpp,
 	&class_device_attr_card_vcc,
 	&class_device_attr_card_insert,
+	&class_device_attr_card_pm_state,
 	&class_device_attr_card_eject,
 	&class_device_attr_card_irq_mask,
 	&class_device_attr_available_resources_setup_done,
-- 
1.0.GIT

--===============24506758292276709==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============24506758292276709==--
