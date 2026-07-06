Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97643F4A5
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341909; cv=none; b=OnMTC9dTUr4f7BNH2xUvkzPiGH7cdvD2bzbjIje6TJdca+wzKVk+1vCCmsSxQWQbJNbqk4JYnM96VW4MscIF5Mrb51Bbgp2yGL8+cjngmLc+wUFtgcHnO5khp3MnMO7HPIxfp6GSeI9CyPeiJ3U0kgAEezbbxIxV7YipUK0EcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341909; c=relaxed/simple;
	bh=6LGnnQUilPleWEktfrY4MmM0pkVSQym5Tb6K8ulPQrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFzhL/fTeoQKBNZLN0F+TBunxsYV/ICNjnrMDt1VDCnHXZTegjS2lWeiBYLbrEe4JAVBCCyVMxRxW4zxaWUY0OoPITrnjhtBsKzFIlK+BlWrtHxUt/pDfTUdmlSSF+pN1qo0iKt0S9r/9R+Olhw7QRzoFQ+BrXbTQ+8MFq/U9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eMDmEatA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AYUKA9xo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eMDmEatA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYUKA9xo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7lC245521
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=; b=eMDmEatA+mntEhDP
	hJg0kYY5ngJKUD2HA6tUAT2pLblN/xbU0CHq6sj91iqZnEeZnVgd4vAdeRzGzMWY
	uoo5jiozfbRr90ky/IFTfnLovnWUDoT7RUSNvkuDAZWQePbASpj3sw68yWJWM0qT
	0zUz2Wp5rOpE879XRKdogY74+OkmzM5N1apchnTZ+Nojt8ltOW3B/faaBbHJL9cG
	4jJVAQNmAfMRAxJpiGEgKfBeyWKKSI3b2Rw+EBZx7jY3ORuS44gDyPy2GjPlm6I7
	uPoAwm/ZJ1ggoI/y2XHMHjZvHWMWw8lpcFwOAfkpMuBrlOvDZchrNOk+iUe4/Jy3
	6voEyw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gjk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:45:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e3ae05d649so37901296d6.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341900; x=1783946700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=;
        b=AYUKA9xoOMnrjyYQxUpt6t/qB5cbGOm/itGzPgzOt06/XXALKVLgmWCasENr9IuwM9
         prLQBb3+ByZFcxEsHbsE217jtTOI2jh8RBPOF3yTZlmTzfqecN9MrA35rItVPdRzTDAk
         EAe5srBC2CWoG5aGvR+DEuHW+Lx8GWRkGZqgbTqGTPYnPAyAZR3GIsh45eSG27RXC/Zh
         0JFiGvEQPFe2WTyo7Da8o5tivW11xpu0lnI5++/nUE5oRjCpsYhrbbIpJqrS3vWZMWEG
         W2BjdUDhWdalhnlUv7brXkW8ACejrISiR7FEI9i18lK4e6BeRAOGybmKKtfLkdJahZCa
         uyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341900; x=1783946700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+yUr04oywdz4IiOeMls1g7Xd5wgtPGT8YOwPRuyxOQ=;
        b=X2pClMlZne7kLxkk96re5VDknNrizCAUu28eJ5vIMbWyUIszKwOd2cg2TGKSZ0bwt3
         YhOZ/rLdMZ1A9hG2g0VZSY9JgDUMonN5ALlzTeCL5201V9TMB3eEkP3GjN+Y2RuSoamD
         jHmDNcj8wtU3oPOEQy1WbiEWX7irN7c32/fkhtuERgs5uVyBRsd9muTyJWDK4x9kxexB
         KHUXAqU5qAVdwl4k2UnYNZ0Fc9eguGmoEcV8Ti1RCmksfZhvzWbZDzFjGcKfGAV4jsfk
         QQi8W5cTFI7evXRw3f9/r8Zcb7IDuvQyjqkK1kO3ZVora14O1CS9YHX9XUyJLQ3dffGj
         Zz6g==
X-Forwarded-Encrypted: i=1; AHgh+Roq34oH1bypADHyGNWMlGSZVCxZBzBO9TfzOavZUiaKGUYhw/5GEu2fufEQmGymejPNax/867+nkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwreT0U9PtB94Lxfav4I5Ei/otnh3oGKUub7MIkD7FGpW9kCRRY
	6e/SJ0c7tZc7vTMw+eo/Oo1N6013kN8Yexv0mY12jN276JO1fusut+rcNzo1aMxUszdgQz5BK9u
	mVhVe71XeOA8fJ4cPy5XgzFUk1WUav7KFlMlp86z+QPJKktBnD9hrlsuO/R+jdQ==
X-Gm-Gg: AfdE7cmWITkR52bRyeInrftg0E6NTg5SUtOPRv+kJVF9XDnLDve0kw0hsipMqrSlRDf
	kLipavkEU/iMaED1ZlBScqh/D6pG7M+13lxcTPEMx7dIKeTyZIhAMsIVxEvu8GR9DKQWVhh3J1P
	7TqOLil82Y690WdMRkJgwmC/o8wR56v7xph45sHQRVDZhel3tUSQ/ovK/UPXY+n0RjpeNA7GZP0
	x+2w92bSd8pxzncVWZ3gXm52N4VuudAwXkGHHlvpsB3uh3d21QN1eN7XEAfJLS9rjqZ62ad8pkL
	tcnWTqBbtc2q6XVNj5oC9hUmAGb4sharPLoX6eGfTon1UuDBTj46gnZtIukorMAisU833nm3gdw
	xMRmB4+XWLbWpXAjQnsqME2b02zXUWyTYGLVO0kD8
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id af79cd13be357-92ebb3a6413mr53862685a.0.1783341899700;
        Mon, 06 Jul 2026 05:44:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:920:6061:816d with SMTP id af79cd13be357-92ebb3a6413mr53854785a.0.1783341899137;
        Mon, 06 Jul 2026 05:44:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:15 +0200
Subject: [PATCH v3 03/20] driver core: platform: provide
 platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-3-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6LGnnQUilPleWEktfrY4MmM0pkVSQym5Tb6K8ulPQrE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MwrXJyI6RDGXR5NSdFZ9xrrITGBOlOKRSQ8
 YpbXqH2OJqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujMAAKCRAFnS7L/zaE
 w/sdEACHAvXLRsU5RV7NL57uR65UVTNYQntV6UGg875BqJxWEvlWfG5SidW+TTr1zGmNWyjwn46
 INxrqYMa02CNieMK5mjLiVaCZWsT1rjXF4OV7zMxUVU9DUkdO4QBiRa6mKZxZHP3qGTcCxK3Llq
 e36oYe9K/9tuGsUmHfogfwxzw6/UIy6Ka89reeczHeRntzFRJpF5TzeDR4T9Vn+z2COOIOy1TPN
 z0/I7QxhkhBmEIm4nhai3oxZGwahkI4CuOrWnohRoujcTlcqg9HHOX5WjfsVRtICbbKFPeQ2wEq
 l+ip9n1y1FL4wuvfQ7VWQigZelfqoka9z0v4ffxsbuMDuZeiOa8dQrBBYoKXZCPTQzX0xhte7Rc
 wLGFEQQnwWVRnmtBjioxssuPAjm/gcAb6ypAO0j8u3ia/6k8jE+6y0ZYpKaDgn7zijlJDPxnyO+
 XFuvWhjfn8yjrT3vF4AmdyxWAszTaUzOfOhTuKMT3cWnj8bJpq4U6GXpv5nztKgHa3iFNntWgl8
 EWhctNRgB+bsLrCzsSwhtoPFZghiAWba4tq8OYctcOhetLOekXjehwdI+MTyoHAYlY2O4bCLNyF
 uBpojQHZsf65MVPDsAHKEHy357eeHVezaSVNZiicNTo5wwdMB5ghmjRAg2WUP8MB1nXUoK2zDEB
 zgEguOOlSD8tZqA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4ba34c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=7s1i5lxVbzGmBzMXG7QA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6uDMjuSstEBk
 BAg4FMrK2ZomDPy54TJgRUrva2S94KkAMLjIGgi23COiEgj/MttCv03BdPJP0wQGfy/Q61mGIUz
 FoTJcyD8lXdQaCiR6XispH+OmPc0Lf5jcGtb8Q9xZLB4pJ9A6qch9eDOhnZK2gQtL3kgrEY2D/p
 AVIsHx+dXSI35veVOeoBKgYpqNCI1+7OoA+m/EFkmMZGhTWtd5pJhfUf2Q5mhxD3/YFnF0vIXug
 z6mZj3bDhE56I0SprsbzaADu3D5U3OoRiaI495EjMgDzxejqC25hFhHFa5NIM5WlvStH5GlMVQs
 Ro9E59JrPnJ8zzaifkgTpzpMYswmgQpIauoKPUBhZ42uGpyTqFilAq0gFRcALwKWD3FZp0WunF3
 3nRtuZUwRk20JuqTfeYO0vPNAEQ58R4a6KfB6QIMi2e40w3gyk65aByjPczaet6yPIqF8VsNmZM
 +RO+AKHQmReky97KnrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6K4efIaQ2q5/
 EMoi5aa7R39Fl+9w8DpA7T8bRVBwa13gmqAM4C/7DNRZj3uMD5bwXYaV6puR5OZPYKqF2p6xZGE
 81gX8zUord+4Hj9z13AGh0yuKhbSVVg=
X-Proofpoint-GUID: CTHWYSE7qWdB4vugMMxXbOS9r_36IxZ9
X-Proofpoint-ORIG-GUID: CTHWYSE7qWdB4vugMMxXbOS9r_36IxZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Provide a helper function encapsulating the logic of assigning firmware
nodes to platform devices created with platform_device_alloc(). Make the
kerneldoc state that this is the proper interface for assigning firmware
nodes to dynamically allocated platform devices. This will allow us to
switch to counting the references of the device's firmware nodes in the
future, not only the OF nodes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 19 +++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3188d5aba5f90622f821c695049cacda030204fb..6520b70cf3052d683a2ecb1a0dd7227575546ba0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -711,6 +711,25 @@ void platform_device_set_of_node(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
+/**
+ * platform_device_set_fwnode - assign a firmware node to device
+ * @pdev: platform device to set the node for
+ * @fwnode: new firmware node
+ *
+ * Assign a firmware node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		platform_device_set_of_node(pdev, to_of_node(fwnode));
+	else
+		pdev->dev.fwnode = fwnode;
+}
+EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca..f037e4101c41dfdbf628d013348d7149ac519721 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -21,6 +21,7 @@ struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
 struct device_node;
+struct fwnode_handle;
 
 struct platform_device {
 	const char	*name;
@@ -266,6 +267,8 @@ extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

