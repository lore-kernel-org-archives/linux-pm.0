From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Tue, 4 Jul 2017 11:11:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707041104390.3346@hadrien>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr> <20170703133602.ejcdu35ku3i63cj2@earth> <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com> <20170703171427.qtpodt7watymphac@earth> <CAHp75VeLV_ySCRN3B=MSoZdyrbXXqqEXrgC+hJCDoLLCJRComQ@mail.gmail.com>
 <20170703182033.5stv5eq33et63coh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170703182033.5stv5eq33et63coh@earth>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.ker>
List-Id: linux-pm@vger.kernel.org

Here is a revised version (not a patch because it doesn't support all of
the various modes) and the results.  It doesn't return anything beyond
what was mentioned in previous mails.

For the following code:

        ret = i2c_smbus_read_word_data(chip->client, reg << 1);
        val[0] = (u16)ret & 0xFF;
        val[1] = (u16)ret >> 8;

do we want to see:

put_unaligned(val,i2c_smbus_read_word_data(chip->client, reg << 1));

julia

---

@@
expression e, x;
@@

* x = i2c_smbus_read_word_data(...)
... when != x = e
* le16_to_cpu(x)

@@
expression e, e1, x, y;
@@

* x = i2c_smbus_read_word_data(...)
... when != x = e
* y = x;
... when != y = e1
* le16_to_cpu(y)

@@
@@

* le16_to_cpu(i2c_smbus_read_word_data(...))

// -------------------------------------------------------------

@@
expression e, e1, e2, x;
type T;
@@

* x = cpu_to_le16(...)
... when != x = e
* i2c_smbus_write_word_data(e1,e2,(T)x)

@@
expression e, e1, e2, e3, x, y;
type T;
@@

* x = cpu_to_le16(...)
... when != x = e
* y = x
... when != y = e3
* i2c_smbus_write_word_data(e1,e2,(T)y)

@@
expression e1,e2;
@@

* i2c_smbus_write_word_data(e1,e2,cpu_to_le16(...))

// -------------------------------------------------------------

@@
expression e1,e2;
typedef u16;
@@

*       e1[0] = (u16)e2 & 0xFF;
	e1[1] = (u16)e2 >> 8;

---

- means line of interest, not line to remove.

diff -u -p a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -187,10 +187,7 @@ static int pca953x_write_regs_8(struct p

 static int pca953x_write_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
 {
-	__le16 word = cpu_to_le16(get_unaligned((u16 *)val));

-	return i2c_smbus_write_word_data(chip->client,
-					 reg << 1, (__force u16)word);
 }

 static int pca957x_write_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
@@ -241,7 +238,6 @@ static int pca953x_read_regs_16(struct p
 	int ret;

 	ret = i2c_smbus_read_word_data(chip->client, reg << 1);
-	val[0] = (u16)ret & 0xFF;
 	val[1] = (u16)ret >> 8;

 	return ret;
diff -u -p a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -77,18 +77,15 @@ struct smu_sdbp_header *smu_sat_get_sdb_
 		return NULL;
 	}

-	err = i2c_smbus_read_word_data(sat->i2c, 9);
 	if (err < 0) {
 		printk(KERN_ERR "smu_sat_get_sdb_part rd len error\n");
 		return NULL;
 	}
-	len = err;
 	if (len == 0) {
 		printk(KERN_ERR "smu_sat_get_sdb_part no partition %x\n", id);
 		return NULL;
 	}

-	len = le16_to_cpu(len);
 	len = (len + 3) & ~3;
 	buf = kmalloc(len, GFP_KERNEL);
 	if (buf == NULL)
diff -u -p a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -68,7 +68,6 @@ static int wf_lm75_get(struct wf_sensor
 	}

 	/* Read temperature register */
-	data = (s32)le16_to_cpu(i2c_smbus_read_word_data(lm->i2c, 0));
 	data <<= 8;
 	*value = data;

