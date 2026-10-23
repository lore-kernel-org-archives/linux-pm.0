Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779445;
	b=yGvp/c2DcLf9C4mnnBjmGwt70kVMFgPDGGLa0YrMkfKNyb3oQ97Bel2rwSzgpEE4IAOs
	 +1411bVl3ZZxBDQqTT+LmolKt4IF0vhVHkMq0+yIhCZN8DI+k/mdn5DqnEKLjOVxawdwU
	 sfY+MtKPseauKADUfCP6nPLBwwLeI2FfubH8OgDVzqLApP3fmVeusYm+PJpfF2aAS6U/5
	 z9Bfhq1hu0hBxfIi5y3XF1RJtxw4BdItnq2R/hFNOeXzrl+1dfEH25o/iyixYenThUAzv
	 hFhll85W/6s4Bfj8UvWNbWFHS8cEhLsS3t8aV1iSfbdGJExGJuOITWu+q5kOSJwUUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779445;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vzut8sLVkheSZYrHGFzChh3dGqwYU7Wnq/4r98pxc2w=;
	b=bF7JNpYGVf06tlGNT7M3uuGNqHSBHq24dH/KyBDI1yffcn+9vOAH6sIdYLnAH2GY0qZ1
	 X0mJY8NOVEAFxqTYj82OVvVUXhZhgsrqgXGxVzdYgmjo6xYKoOuNtXVgSB5/bQNEDxCJI
	 UGthXJl+hl3Kj8Qi/Av5VXSGV6GrQhlidpNudqMiWXrtcg3OuBIkDiiZSTXxQ3UTNDhge
	 f5t6jOGDyEeDR7c4FG4MYn5Bq8ADWPkeY1UhfsOmkGHGWXStx3Veo5E2C0qqbUIax8Rc4
	 XLojlVHT1fn3owsFGJeh2fCNODWXxgjsFb4LSmpBgfNPh1mBUD/a9XrhE0YtQgrwZlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=I+KCUmfU;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25488606A327;
	Fri, 23 Oct 2026 18:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25488606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=I+KCUmfU
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54B8D1CF5;
	Fri, 23 Oct 2026 20:15:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792779306;
	bh=VM4SmKYXyPST01Ns008m2FL/eAsDF5GFaUJ3P+guqGY=;
	h=From:Date:Subject:To:Cc:From;
	b=I+KCUmfU3tUxNobBdbpZHtwcmGjQSdbYu/k1FNurI20En5uE3XcPZQgH36/PqzV0l
	 YeEP8U/PTbcmCx8/SBnl2ZtDh6lf2W4omEo0IjHfPEGoDbWDUpOVEA337jDQy7veGd
	 90ZX+GLWx0yhzS/cG+NPjtPBDWQtwr06oPGMDJ48=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 23 Oct 2026 21:16:23 +0300
Subject: [PATCH] pmdomain: core: Add genpd_dev_pm_attach_by_node()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAHak22oC/yXMUQqFIBBA0a3EfCekgkVbiRCzqSbIQn2PItp7V
 p/n494TAnrCAHV2gsc/BVpdAs8zsJNxIzLqk0EUQvFCSLYt2sRo7KS7Q7u1R8ZlWVVKiUEaDqn
 bPA60v8+m/Rx+3Yw2PiO4rhsLOCPpdQAAAA==
X-Change-ID: 20261023-pm_attach_by_node-13788662f3a1
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11431;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VM4SmKYXyPST01Ns008m2FL/eAsDF5GFaUJ3P+guqGY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq26SqNHqUuwmINAa64L0wcZqJ3ATRH/XatZM2O
 hW4Eii+fqiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatukqgAKCRD6PaqMvJYe
 9bOFEACrKJ6TpkE0a5FrjuOdKXfPZF01v4XuR7I3ITZ3Fkr8IA8Fs2TZ+k8NFxRUIq2MarminmS
 7+qZomkFilaDmG6ux1MmjYhJvhObE2vJ1p92CAJYEWuvLIooY3BvOVVmCDe5Q3iRlnU+NHOkruw
 UlX1l9a4S+q8tpDqjzcYIDixv9szOf/zQ3R2i1Do2reqZ9tcoGi5EEvh9v63Cw9pitiFV3MYvFN
 56tC1WQuXexhWNerjJjePRP09ClDGmJ6U5OQkSqX3OUlTczorEOcygmM+4jiZiDS2BwnvQc/DVE
 IzQ/qxALduFt5i9cgfgwDtgRGDzoCPTmBc7fe4/DkwGJwU6CjLoJfLn1IOUKMkhtayj9dzrNtvu
 bzMm61cItw6tA5jrufEv9PcBHqp2j36i98t4NVnS6IyIu9RThQi649QuaMffdiWiVxwID/58b1I
 r8CUpRv0Z/QXVLwCQVcRjoviuUT+KFXJQknqBjQ5hbkulAv58E3uMFIhyEE0x0pGWqeNGN3gO6Y
 qYwaveOT6DD39A+xiq5WyX4V1K6hXNH9mYXZqCYs9TaPs74bsADFT/rMG07sTmMv96WGBDV7UB4
 /Gxnr8QEY2SjR45vq7BcD9iT/z1dSq+K8HZcD6/u3byXAS2mTVIS8Kg9E7eYOcQYFFmRUHDPLQ5
 j6Psn2GvSHO6Mmw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
virtual device to a PM domain listed in the OF node of the passed
device.

Some hardware blocks are described in a child node of a main device.
They have no device of their own, but they do have a PM domain of their
own. Neither function can attach that domain, as both parse only the OF
node of the device.

An example case is TI's display subsystem and its OLDI (LVDS)
transmitters:

dss@30200000 {
    power-domains = <...>;

    oldi-transmitters {
        oldi@0 {
            power-domains = <...>;
        };

        oldi@1 {
            power-domains = <...>;
        };
    };
};

The OLDI TX blocks are not part of the DSS IP, but they are not quite
real devices either as they don't have registers of their own, and are
instead controlled via DSS registers.

Add genpd_dev_pm_attach_by_node(), which is similar to
genpd_dev_pm_attach_by_id() but instead of looking for the power-domains
from the passed device's DT node, the DT node is passed explicitly. Also
add a matching wrapper function dev_pm_domain_attach_by_node().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
This is a new try for managing the OLDI power domains. Previously I
tried using auxiliary device/driver for OLDIs, and handling the PDs the
normal way:

https://lore.kernel.org/all/20260529-beagley-ai-display-v3-12-7fefdc5d1adf%40ideasonboard.com/

Then I realized an issue, mentioned in
Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
not be returned if probe() has already created child devices".

The PD virtual devices used in this patch's approach do not hit the
issue as they don't get a driver, so they are not probed. The tidss
driver's OLDI part can then use normal pm_runtime_get/put functions to
manage the OLDI PDs.
---
 drivers/base/power/common.c | 27 +++++++++++++
 drivers/pmdomain/core.c     | 97 +++++++++++++++++++++++++++++++++------------
 include/linux/pm_domain.h   | 19 +++++++++
 3 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 9bef9248a705..a873541f9350 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -171,6 +171,33 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
 
+/**
+ * dev_pm_domain_attach_by_node - Associate a device with a PM domain of a DT
+ *				  node.
+ * @dev: The device that uses the PM domain.
+ * @np: The DT node with the PM domain.
+ * @index: The index of the PM domain in @np.
+ *
+ * Like dev_pm_domain_attach_by_id(), but the PM domain is looked up
+ * in @np instead of the OF node of @dev.
+ *
+ * Unlike dev_pm_domain_attach_by_id(), @dev may already be attached to a PM
+ * domain of its own. The driver controls the power to the PM domain through
+ * runtime PM of the returned virtual device, or through a device link to it.
+ *
+ * Returns the virtual created device when successfully attached to its PM
+ * domain, NULL in case @np has no PM domain at @index, else an ERR_PTR().
+ * Note that, to detach the returned virtual device, the driver shall call
+ * dev_pm_domain_detach() on it, typically during the remove phase.
+ */
+struct device *dev_pm_domain_attach_by_node(struct device *dev,
+					    struct device_node *np,
+					    unsigned int index)
+{
+	return genpd_dev_pm_attach_by_node(dev, np, index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_node);
+
 /**
  * dev_pm_domain_attach_list - Associate a device with its PM domains.
  * @dev: The device used to lookup the PM domains for.
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 052ec478dfcc..327fbd40c854 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3462,34 +3462,16 @@ int genpd_dev_pm_attach(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
-/**
- * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
- * @dev: The device used to lookup the PM domain.
- * @index: The index of the PM domain.
- *
- * Parse device's OF node to find a PM domain specifier at the provided @index.
- * If such is found, creates a virtual device and attaches it to the retrieved
- * pm_domain ops. To deal with detaching of the virtual device, the ->detach()
- * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_detach().
- *
- * Returns the created virtual device if successfully attached PM domain, NULL
- * when the device don't need a PM domain, else an ERR_PTR() in case of
- * failures. If a power-domain exists for the device, but cannot be found or
- * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
- * is not probed and to re-try again later.
- */
-struct device *genpd_dev_pm_attach_by_id(struct device *dev,
-					 unsigned int index)
+static struct device *genpd_dev_pm_attach_virt(struct device *dev,
+					       struct device_node *np,
+					       unsigned int index)
 {
 	struct device *virt_dev;
 	int num_domains;
 	int ret;
 
-	if (!dev->of_node)
-		return NULL;
-
 	/* Verify that the index is within a valid range. */
-	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
+	num_domains = of_count_phandle_with_args(np, "power-domains",
 						 "#power-domain-cells");
 	if (num_domains < 0 || index >= num_domains)
 		return NULL;
@@ -3502,10 +3484,14 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	if (!virt_dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
+	if (np == dev->of_node)
+		dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
+	else
+		dev_set_name(virt_dev, "genpd:%u:%s:%pOFP", index,
+			     dev_name(dev), np);
 	virt_dev->bus = &genpd_bus_type;
 	virt_dev->release = genpd_release_dev;
-	virt_dev->of_node = of_node_get(dev->of_node);
+	virt_dev->of_node = of_node_get(np);
 
 	ret = device_register(virt_dev);
 	if (ret) {
@@ -3513,8 +3499,13 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(virt_dev, dev, index, num_domains, false);
+	/*
+	 * Try to attach the device to the PM domain at the specified index.
+	 * Pass 0 as the num_domains when np != dev->of_node, so that the dev's
+	 * required OPPs are not used for the PD.
+	 */
+	ret = __genpd_dev_pm_attach(virt_dev, dev, index,
+				    np == dev->of_node ? num_domains : 0, false);
 	if (ret < 1) {
 		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
@@ -3525,8 +3516,62 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 
 	return virt_dev;
 }
+
+/**
+ * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
+ * @dev: The device used to lookup the PM domain.
+ * @index: The index of the PM domain.
+ *
+ * Parse device's OF node to find a PM domain specifier at the provided @index.
+ * If such is found, creates a virtual device and attaches it to the retrieved
+ * pm_domain ops. To deal with detaching of the virtual device, the ->detach()
+ * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_detach().
+ *
+ * Returns the created virtual device if successfully attached PM domain, NULL
+ * when the device don't need a PM domain, else an ERR_PTR() in case of
+ * failures. If a power-domain exists for the device, but cannot be found or
+ * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
+ * is not probed and to re-try again later.
+ */
+struct device *genpd_dev_pm_attach_by_id(struct device *dev,
+					 unsigned int index)
+{
+	if (!dev->of_node)
+		return NULL;
+
+	return genpd_dev_pm_attach_virt(dev, dev->of_node, index);
+}
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
+/**
+ * genpd_dev_pm_attach_by_node - Associate a device with a PM domain of a DT
+ *				 node.
+ * @dev: The device that uses the PM domain.
+ * @np: The DT node with the PM domain.
+ * @index: The index of the PM domain in @np.
+ *
+ * Like genpd_dev_pm_attach_by_id(), but the PM domain is looked up in
+ * @np instead of the OF node of @dev.
+ *
+ * The virtual device is named after @dev and @np. The required OPPs of @dev are
+ * not linked to the PM domain.
+ *
+ * Returns the created virtual device if successfully attached PM domain, NULL
+ * when @np has no PM domain at @index, else an ERR_PTR() in case of failures.
+ * If the PM domain exists, but cannot be found or turned on, then
+ * ERR_PTR(-EPROBE_DEFER) is returned.
+ */
+struct device *genpd_dev_pm_attach_by_node(struct device *dev,
+					   struct device_node *np,
+					   unsigned int index)
+{
+	if (!np)
+		return NULL;
+
+	return genpd_dev_pm_attach_virt(dev, np, index);
+}
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_node);
+
 /**
  * genpd_dev_pm_attach_by_name - Associate a device with one of its PM domains.
  * @dev: The device used to lookup the PM domain.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f925614aebdb..c38c90d63c02 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -477,6 +477,9 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   const char *name);
+struct device *genpd_dev_pm_attach_by_node(struct device *dev,
+					   struct device_node *np,
+					   unsigned int index);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -535,6 +538,13 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 	return NULL;
 }
 
+static inline struct device *genpd_dev_pm_attach_by_node(struct device *dev,
+							 struct device_node *np,
+							 unsigned int index)
+{
+	return NULL;
+}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
@@ -560,6 +570,9 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
 					    const char *name);
+struct device *dev_pm_domain_attach_by_node(struct device *dev,
+					    struct device_node *np,
+					    unsigned int index);
 int dev_pm_domain_attach_list(struct device *dev,
 			      const struct dev_pm_domain_attach_data *data,
 			      struct dev_pm_domain_list **list);
@@ -586,6 +599,12 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
 {
 	return NULL;
 }
+static inline struct device *dev_pm_domain_attach_by_node(struct device *dev,
+							  struct device_node *np,
+							  unsigned int index)
+{
+	return NULL;
+}
 static inline int dev_pm_domain_attach_list(struct device *dev,
 				const struct dev_pm_domain_attach_data *data,
 				struct dev_pm_domain_list **list)

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261023-pm_attach_by_node-13788662f3a1

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

