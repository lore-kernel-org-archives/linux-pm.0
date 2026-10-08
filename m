Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com [34.2.64.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2603290B9
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.64.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469550; cv=none; b=Cf+HbAsO1TLK1QgBlc50v+2cZhh2zGCevLepUxFXA7K+vzJE0o+lyw/fQpzHeE/qf5RqLo4ut8DqlbQd88p0b6QjsyodCAsMCrMfVFXVyravohokgrdtX7xG0shRPfk5fwtAtfnPMpp0rG2XJOTYnW4fHzA9va2VDkamYW3bXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469550; c=relaxed/simple;
	bh=c5pi2NgFEYGfCq4NfJfYezKCEaQhO9dZpfCnyXzDQsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBWZ0Qh1DdO/znodKoxsDZwPmRQrZjGVJxKns2q5q6lNfRdTmjao84EdB80A2CS/aP/MPwYqRRhrVaiW8sEK3YWy3u4L2cyphAggwyEDyIdWBJGhA1lX2wnmtxb20msIvYRCgAU+YQ8WNvUwriMRwdPDduRqJ5eK8GzukA+cG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SP3h6WVn; arc=none smtp.client-ip=34.2.64.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SP3h6WVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791469548; bh=c5pi2NgFEYGfCq4NfJfYezKCEaQhO9dZpfCnyXzDQsw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SP3h6WVnFDFApr8/eGj/TlVzEUX5wzdsY6i5QyvU3ToaBzeKYB9GNMOlSFMB4yL8eFZBld0lACRz5ODkABx51Q9nsi3isV4uzmAIBkS6rd/pDcDvilnh5ggMhYOb9jZVq6XwX+Te7JWbUMUlVTtz7UuTAGe8STj/dnUgVVulblJx+kQkbqSIW6uB+GBCA3UvF7QMONdd2BhFd5AK0TkwkztaOjoVLPdwosKGR58/LTvw5NN4KZy/jg+NZagXZg6ZyF9gGdB9H1CJva3hfxeq5sHSTF5SQ7lUdOLKDqtAPZusCZ/a6T6OzRPuoD2TwuxWpQbxUyOHOFGhRZrRJtMHrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791469548; bh=LGHRUlkZHaASqS7/1xxsvPbE7jgSXvbwvLk079oC5XP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iOmMywf3NpKMwicOVyOM7c+k3MptMRR7DEC5MB/SvcukVQj6tkNxUamrs8sygNdV9WwhTq4AELZgs9kvkppSrNy4sPtaXN7TPIg/OVGDf7+vs/gET4qpFUIZ/WzuxFb2iivms+DXVzFDndOHR6UvEc4pkG74mqF4kEFLoSOeYyj6oerbbAcQ1JM4lVP3zwb/Tn0tsR6TzHu38CiEScTUEiUFd9BlT1a33m5nFfipG16on9kWM9adNprLh5n2dlMbf/Vf7x5qnCekWt9nARu/ICMH2+SS7dYrYOTvqNUr7pXRFX1hcH4txGRfmdNLouhvtvP0XcQkZVO8MQqUiaojLw==
X-YMail-OSG: LSs1eq0VM1kFGK40ZhwHV54.9IaBF5blCu1pWU1gRkTmXxMB.ckOjlmHmddCQ1p
 CCNu0JGLoAeGzJo9CjH1atWfEzOHQAD9rDDfltz.UyhV3qHY9tiTVhNP3SosFZbqnfFq2pTIWMCG
 VXQBHm400jmDncBXptDsIZfHsukc2E55HqN7.bvLSEG7yz_5Nqj6PlfvhwxoeF65m_Wq1rjfa.Mp
 tZtVlUhPphzWtageCb.1Ya2FY3zPW1iHfVVG.d9zILCk8R2JT2SOvUiJwJhKVNSBwwUHm5MSakes
 hqCAObse5Ia7efjq4snlR722wi4bq.kutwbHn_dcHiOTDkdVloBykx4DkehGh3HZefNbgddkcABO
 qmeDg13Nxhtqh_BCLGjqn5LX4ZSWCH5jXIV9O7BWzSNTq81ANVBnUCjdWls8n__ura3fi1WfEBHE
 AtYYes4Mua7pBSYwlJwDYZA2l_6bwnfM8jiUsScG_vM36ypD0NJJqxRD9ajXjMx3ca7x07z2hWB2
 05XUZZe7N0ahQPxG6hBwtUyhHmNLM8RPidb4zY3.FvPduO_tfNRO6hENM_.4hbjvqFZICwaOFZfr
 E8NGRc6Q8rfe2ZwL.LMYihAeUWRG6q5Gaq09xp8Yb1KSew33TNW_3FWr92aH3BUdj_FyZkDWVxKf
 E3HegFbOcpwaWdc2kgPpR4csFsPBy8vxp9xE5wfsYHv5KtQ9ti.9u5tyXbxQzb5SliqEWYJAmwPG
 _lIgapn8OuNRbNh5snAxVfkI0lRDZlgPgfadU6KPK_Fi0mr1MQUg7fMVSxB7c9Wp9twJ7NIywg3F
 NaklL8OtVTPRyBsbGKucDkhifeyXHMmsJsLD1oWbOvyNqfDnA1mVJBtKwjXsmx3zEWcZMNXe_SDQ
 clXDrLUvT710NLdEt7kJmczzdVjv3pkiiJler.bkEyGM3nZcwpRy.bfM3hpoXAzxsrvKf_UoizH1
 T.owAUI3nxz6mg_3DOGvBCPb5Z7mKvraSKHzyul0jVAY6zqU2GVHvLvTcl7uOh_UOj_XE9oHAv34
 1Zx9DlL7Bu0rm2vtvRXQ.Iw0yHB_cBMWhqn1nUJIj4yMPJCfDzTJMXG4vPkH7MPPB_.BsH2mLhvB
 6Pt6u.Vs3cdJNVrirQ6b5szf7b8vlMewzyLOZhXga1dLj9O.E1t390zF_g970qLbqE7._ut1n3Wj
 77_tdVnU4mjcxlATWH.FSS44Sw_65k4fzGxzgveOk7_XLIggaVv4Wnxj2aFFB8jfvgvsrjn0YF1z
 NupbpkcPoCLL0mmxCU_FWN3mG5UAgws7gFq83LVZ67WONt5Tj1OvXCnEYgi_j1YhN4M8KadpRR29
 DmK5vdiKbOTqB1UZhJn9TTgau8zK6De5gYgWd18djoy2eZDyfi6izyR4d9QYl6bRLCGB8rhd4DXf
 5wmr0oPzBJS8mpAyTXcMtrNKNfS5d_EENvCfQ9dS7_kybiQtAHOHzVJ9WhQIEUHaXqQS1mllDsMx
 sXB0Q_4Hilk72b_WMrbWizKcUBMftq7OLAhYU1zJq2Y60KBpLDNogYbmwO1VjQEIC8r2aDvIfpH6
 BGs1TjfPVT6oCBiwoZRqflcm71vj2M.kDc7s4CHz7gQTAC.yAFx0GnC2H6iuSMYblIGTgeLJKzXA
 DmzbgxJ7uo5q7CLroKREvQ1OlC3wQWcrPD3NThcEQGf6W.RJgGi68BnqsD6nzZydEn01RPUzm2D2
 cJLWFXbcCYh3ODWPWqjUqwwlZ0I_9hKWSLT5GD.mSKMIe6NMvdFoW1QNII7bkRaL_n3kC01rbcjm
 kRlOTQPKc9ordBln3tXbNHGdxSsA1Uhw6lYQLvHYAXihsBwWFY1rBBbkI5IbEz9gplCh31J1xitV
 _3b.hkbKOZOvrCMPeZz.DcMEwK4U.oSfPDk0_eWnvTkLNROJd.YzDb.4ju_FBIYqB5xjTtiPUQx8
 _1UmaHAvElt2q2gw1p.U4AlWhiI_XA_mZqX80rFPk6aA.Cfnj2HZkhQVeZ4Rg0jSnELUFZvDNrza
 UX__XvcjRKoJH6UOWUUYf8tI90sEYi3s01CP3EVOGlA--
X-Sonic-MF: <capitain_jack@yahoo.com>
X-Sonic-ID: 6bea63ff-e19d-4b65-91e2-1e4f203e200a
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP; Thu, 8 Oct 2026 14:25:48 +0000
Received: from dip23.lsn.bf1.yahoo.com ([67.195.177.32])
          by hello (SMTP) with SMTP ID ce0d74e82b9735ee0573dfd517ed1e48;
          Thu, 08 Oct 2026 14:25:43 +0000 (UTC)
From: Daniel Ramos <capitain_jack@yahoo.com>
To: Jhon Taylor Forbes =?utf-8?q?Ca=C3=B1izares?= <hermanojhonforbes@hotmail.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 keyrings@vger.kernel.org, jarkko@kernel.org, ebiggers@kernel.org,
 rafael@kernel.org
Subject: Re: [RFC] power/hibernate: TPM2 image encryption to allow hibernation
 under lockdown
Date: Thu, 08 Oct 2026 11:25:39 -0300
Message-ID: <179146953927.3470668.11045077335347628577@yahoo.com>
In-Reply-To: <acHPLiT4lZdTp0wD@srcf.ucam.org>
References: =?utf-8?q?=3CIA1PR14MB62243E515C24AE8BF40E36BCB14BA=40IA1PR14MB6?=
 =?utf-8?q?224=2Enamprd14=2Eprod=2Eoutlook=2Ecom=3E?=
 <acHPLiT4lZdTp0wD@srcf.ucam.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo

Hi Jhon, hi Matthew,

Jhon, thank you for starting this.
I build Sparky Stereo OS, a SparkyLinux edition, and we want Secure Boot
and hibernation together, so we ran your RFC through a small test bench
on 7.3-rc6: QEMU with OVMF and Secure Boot, swtpm as the TPM 2.0, a
scripted hibernate and resume, and tamper checks.
Here is what we measured, in case it helps the next version.

The patch does not apply as posted (git apply reports a corrupt patch at
line 59; the hunk line counts do not match their bodies), and the
lockdown hunk breaks the build even with the option off: the enum is
LOCKDOWN_HIBERNATION, and snapenc_is_active() is declared nowhere.
With 17 small fixes it builds and boots. Sealing and unsealing could not
be mapped to the in-tree API (tpm2_seal_trusted() needs a parent key and
a PolicyPCR digest that nothing in the tree computes), so we stubbed
them for the run.
Under lockdown=confidentiality hibernation is then allowed, but on the
default LZO path the image is written in plaintext while the kernel logs
that it is encrypted: the hooks are only in save_image() and
load_image(), the nocompress path.
With hibernate=nocompress the kernel oopses while saving, because the
AEAD associated data are not in the scatterlists.
With those chained, the image is still plaintext (the ciphertext buffer
is never written), and resume crashes because the decryption context
exists only in the memory of the kernel being replaced.
A tampered image is caught only by the existing CRC32 and LZO checks,
and a change of PCR 23 between the boots is not noticed.

The detailed logs and the fixes are available if they help, and the
bench can run any later version unchanged, including a design built on
the requirements Matthew described:
https://github.com/Sparky-OS/sparky-stereo-os/tree/main/tools/hibernate-bench
Disclosure: the measurements were made with AI assistance (Claude),
directed and checked by me.

Daniel Ramos
