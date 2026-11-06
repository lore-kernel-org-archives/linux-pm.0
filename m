Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969873;
	b=FaqkPyYISCE6l8zhlI5P44dM2XRl8R0qWCovMyHDJ/2aq6ta443HWHZRRv4xFbaJ95HK
	 yiPZAcR6PMzxILGpNGFDpULqHdt7t18UG+nSUH2nu7jjL1J7zQ+2PiSmQ70EL/sjosCZN
	 nXdak1h56lb1it8GC4dY25Sz7Ps2A93XlXaif9IPvztoDz+FieW9usBKSZP3Mqt5KeBZ1
	 CUS2uGyZaRN0OFgXs9D10YwdZe6UX7Yf25vrISVFCZNGpKQbo+nC06wtL31bew9nIYFC1
	 3UstIhVUViX+uT2o1VXV0rINHaRrholTsFTQY9oVcepWpXxM9DjJ1ucaAFjGG509YXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969873;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=bdazGzEMHpNo/xFZo4UuACj+NPbyfyXOOELqau7KKIc=;
	b=Vc+KyaXEAXS0V+A40KdIDB9TOah7kUdFWAS/+9KeAmAKHcJwq/D86b/7i5uItPzudR95
	 9oMm09tvHJu56qBHnkYeIG6W/9ZqwMCV+PFqFHdvhHsbWG0gaOVSbqGmZlEgOrBY46XY9
	 mTe8giAuP03wPXp3P/VxFqO9ugAuAPhCkFJ71LsVIapI5i170hYMRR1Tyj1m5yi83v/d/
	 MXC8lX4FgLSpYkQU25LXkQhF0/3J+hQakDQzYprhNQq40L/vM9vhr7keiz3mM/A1J7JPD
	 6CEoebJlJnbbieEMTdcps6fDhIfGXyJqYw/zTrupPNVdie408+3NWJsOq6UqHwXMw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEVygYOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB9606A326;
	Fri,  6 Nov 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEVygYOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D98F1F0089F;
	Fri,  6 Nov 2026 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969872;
	bh=bdazGzEMHpNo/xFZo4UuACj+NPbyfyXOOELqau7KKIc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=dEVygYOqnRrT/sVNMu9qV4SOCkeLfSYdyomWHU2oiXdUiH9en1YWEYdmgfqcgbeS6
	 txS1KoPhhLGfx6EZmUw+giNlzPy4MFm1GCz+fngS9NM0ZUDHEnxt7vO5SFN73eTSeX
	 xp7c8Zrb3W+Z+Z2duQVDEFf3Kk6Y/FZ1oLyFNHveJOg20rJHSdf8yvlNA7iTQZmw9Y
	 rgknbdP7HeCFl4+3rABR7i77LhbDR7CpdYp6Ts9sVSgerBTQBq/AgZLLiQDtCMedHo
	 nzU0NiJq9EfXXM9WQNp4OfhY69bLuRoyyVwCwCNIl4157mEb4FM0mkRleIFrofs1iy
	 Sj9e6EIQQR1xw==
Date: Fri, 06 Nov 2026 06:57:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Anand Gore <anand.gore@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 devicetree@vger.kernel.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kursad Oney <kursad.oney@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, William Zhang <william.zhang@broadcom.com>, 
 linux-hwmon@vger.kernel.org, mfd@lists.linux.dev, 
 Brian Masney <bmasney+clk@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>
To: Linus Walleij <linusw@kernel.org>
In-Reply-To: <20261106-xg6846b-bcmbca-xrdp-reset-v3-1-d6adeb71afc9@kernel.org>
References: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
 <20261106-xg6846b-bcmbca-xrdp-reset-v3-1-d6adeb71afc9@kernel.org>
Message-Id: <179396957046.2456734.10877146693637618600.robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: mfd: Describe the BCM6846 PMC
 complex


On Fri, 06 Nov 2026 09:26:44 +0100, Linus Walleij wrote:
> The third generation Power Management Controller (PMC3) has
> different subdevices.
> 
> Identify the parent with the BCM6846-specific "brcm,bcm6846-pmc"
> compatible.
> 
> Describe the complex as a simple-mfd with a PMB bus child owning its
> register resource. Include the PMB clock and reset controllers and
> PVTMON, with its acquisition clock and reset resources.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 87 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml: Unresolvable reference: /schemas/soc/bcm/brcm,bcm6846-pmb.yaml#
Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.example.dts:18:18: fatal error: dt-bindings/clock/brcm,bcm6846-pmb.h: No such file or directory
   18 |         #include <dt-bindings/clock/brcm,bcm6846-pmb.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/linux-dt-review/Makefile:1726: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261106-xg6846b-bcmbca-xrdp-reset-v3-1-d6adeb71afc9@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

