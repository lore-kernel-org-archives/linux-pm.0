Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63421357D08
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558944; cv=pass; b=Z+rwkSWYndLyoaycTLgFbfFtFRrtb+rQt2BweSdAoBgjv/ZFkgAdesDd6oBgkcw6fpPFQcTpAATHyfcPHZX2+BWWlzBxAliYmG4Jlb9YsTvZ/FbnDGzE26whnGKUpKfZeiH7ZhZEiyKWnFhup283RjcFoHjZekcTN+nsC4dfbUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558944; c=relaxed/simple;
	bh=xvA8DTirzMNyhS52A8f+1loxVqPpu9nQXkLXOqerews=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcIbCTd9N23gcbubt51U/Qn2v3nh7b0ZGTbXHBQ3S49Br3rW+2MdLMhqEVhv6ygt5McirIXj/nGZHQa0SaKDEyqtrWsbyvk77MUG6SSNTd00aRPYO+287csuqXmn3gTJ6qLPEWO0Z2+DJI4fe8oCJQpR7FYRejoDqLzhCgL3AeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYVvTc1H; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVvTc1H"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9199927cb42so23141226d6.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 08:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791558941; cv=none;
        d=google.com; s=arc-20260327;
        b=TPDtlS7yBH86sX+BaD6VR+PlEmqOYcpXgCT9SlX7hd2+boxY10cSSVZzeG8E1t17dZ
         4tRSwSIdJlgofGx8V6uZUp2rhUzJayejNy6aUzkfp53BZQpjmjNI/+RLoFA5F5Kifvza
         EnnyCqkx272YhXF4MEEVJNtzu43WYmQ83xEu9fOM6YOPNN5w5JcGGJ/va4P7FUgg9Lc+
         xC2nUufpXIrKeOvmE1dy4KNCZZz8L3R6qGYOrMLBtiPfXY/aEgER8ntBnJchSdBVQZn7
         1WDTJ/b50SBat+NZS16X21ywg2nd5s25tTtU6i85CwxVa20i4UqOAH/mxicYa66xOfEP
         zWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=liSfgm3aLspZBk/EvQTw5ZezUOYb7ES99ZZ1K8Pg3bo=;
        fh=uixDieX9rcyAxf2jWj4Fo6E1pV3UvuZmZ9qjTLCB4MU=;
        b=Hvqp7WSdkWvlfdGoPan9aOKzojUu4PbNt2MOsw3Si7g8Td/6q6d3yCNPxuQiNdu1Y3
         MHnmHDZmS5qMs5h8NH7WNiW3/9w+iSbWcY8WohotUKbMAhpUDJcTdmRFvgKJP5xzcNaH
         YAgesiUd1eGuGBlYkXrXGAh7e5/m4JRDPXXXjrGEQx+rNaTHg0VPEUvb7B7mNKFBCueg
         eAN06WbCu+c7eibSJzeqve42JSmFlWSXz8Sh5o2OW4EKz1Vw/ri1ylLg6XhvVKK81GZM
         XMJNPVFXWGcdwwuXIVwnNZfZpeLZ3Ep84toApU3cZZtn40648Rswm2LLj715SWX7aV2a
         WGVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558941; x=1792163741; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liSfgm3aLspZBk/EvQTw5ZezUOYb7ES99ZZ1K8Pg3bo=;
        b=gYVvTc1HAv1GJYETcIWnG6sJrHeaO2yVkq/jA5JpDnvcmzCDtIxWtzkhE04kuBJMzw
         oPTITqRxv8L6ZqrGjdtHT2xI4NyMZ/ZS38wh4tZ/KOjrk4EHt8NAYAkhd/3oIkXI88iw
         mXaGKfMTbwj65C6xD6u6z1+udIAwV8woLg898RiqBFPYFyQfsjKoYlZX04LUfEICd3bM
         J5b4/rACNEdwtzlwCIFRJN31REabD/cpzOvcORgxL8w4z1WXArRO5dSC1OLCjUXHXHq0
         SVg8wLFsk4e3k+laNInWMFrl5JVZQU6LUhISMWx3VH28kuS7UIZKyqd5hCJT5KEEQXf7
         Yi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558941; x=1792163741;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=liSfgm3aLspZBk/EvQTw5ZezUOYb7ES99ZZ1K8Pg3bo=;
        b=hdxBPqvwKIcCxKfk1a3SnnbCgzRR6MxOThdFs3kcqNRz1T4k/ShXan8zRLvIHRxAWt
         w5jNmbor/rM/0btDDRBLeUGsF9dpsyr86HCg21H5USBoU8h1G1gO9QCcVrQON+Ane74v
         NIHrKbbYnHN8PrpjlQv1ykmTn/dITlaQ5WwM8vnwnJH/ySRca4l7tTO0f6jdm5R69TfT
         0cKqKFZNCjvYed+WPvdq3VFvx02/mns96Y2RHXXMS8oINUsXCaUxxF+JIs0biBulq3FU
         JKLdUxmEGLxAJFbw/lRDFEItIkwyqQmOvJz/UZGOetIISgPvg9Fyg0gmbpl2V4Etl0uX
         68yw==
X-Forwarded-Encrypted: i=1; AKwUvByuAlx2A720j5L0LrTXnNarVEITTgjMC04wdKyCYGBmFuSoBQEiyllyfoOETiYoL5eCD/J0D747BA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ3l7h8TAubMrJGQ4O4EJSaer8Jc9Bkq5TSlXBL2AkdBsvKsmU
	kpoEJUyEWwJpdmFWULrcFHm6pHcKQnB4ZISolnvBuhLAczCuVBAMh/PrlF0DY6yHy+6SHlKgoCX
	9I88pL+aT/RDO+xfXKh/AWCaGhOiyRjI=
X-Gm-Gg: AYBFou3C/plGgdCDtMKq98IlOE+MAQ6VK+NzyNeTF5dDaGQ7LzPaD5T24Eytsvvz7uy
	dM+Dwf8wdBH5F46s6pVnVO1cPjuIT1qiGVZmOi2vhbrYxUzIbNTRqjV9rdU/pDBdlj49T3hSk3H
	JebHpgyfo6nRKK7qnR4cGWkXE0zW4ubR6Kjl7swMfsJ4Zr3gcuh4glpfR7JrYgMNiIW6uNssHyP
	eJYB1YPAUzBOiOr/cXyRRMaf2G2cTw3tOBDEznPUn/GUgYtK3YiFqme2hCV0iaqq9n/EATjezYV
	foh9pnTP6KxGijiUQSLe0+VK1KVGDzhXHKiuEXnuQzrPX/Aud6LVRpJe3sPWmcFiL4fiHM5XoIC
	+K9uzgcmqtKP9d50/tUc8hPrJWEFR4qQhjQ==
X-Received: by 2002:a05:6214:4e82:b0:91b:5d3a:510a with SMTP id
 6a1803df08f44-91b5d3a56admr20534886d6.56.1791558941026; Fri, 09 Oct 2026
 08:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009073330.18175-1-ansuelsmth@gmail.com> <20261009073330.18175-2-ansuelsmth@gmail.com>
 <20261009-7326174694c52ccce16615b2@squawk>
In-Reply-To: <20261009-7326174694c52ccce16615b2@squawk>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Fri, 9 Oct 2026 17:15:27 +0200
X-Gm-Features: AclHuK_TaWQMRaZGsQ3qxEM8_zEYr5bmwxiSK0Zad2EZWuG4HWavWzZ47j3MGaA
Message-ID: <CA+_ehUyP35PF6cm17dzeLcREVFEPv=89Do-s5-hm-T3mKveuKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: Document support for Airoha
 Subsystem Scale
To: Conor Dooley <conor@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 9 ott 2026 alle ore 17:06 Conor Dooley
<conor@kernel.org> ha scritto:
>
> On Fri, Oct 09, 2026 at 09:33:28AM +0200, Christian Marangi wrote:
> > Airoha SoC contains multiple subsystems that are scaled to a
> > specific OPP taking the CPU clock as reference. Such subsystem
> > can enter idle or performance state based on the system load
> > and power consumption conditions.
> >
> > Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> > Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
>
> The device you document here does not appear to exist at all, since it
> just consumes a clock without any registers or anything. Why can't these
> operating points be added to the actual consumers: the switch, the npu,
> or event the bus itself in one case. In the bus case, I think that's
> exactly what simple-pm-bus does?
>

Can the consumer be registered as a devfreq with all the other thing?
Isn't that problematic?

Also one big problem is that some subsystem are used internally.
Example SOE and BUS. (and also NPU)

How those can be configured to follow the CPU frequency and
use the required-opp and opp?

> >
> > Document all the required property and provide examples for the various
> > subsystem OPP + subsystem scale nodes.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
> > new file mode 100644
> > index 000000000000..2cf7f23a926c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
> > @@ -0,0 +1,114 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/devfreq/airoha,subsystem-scale.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha SoC Subsystem Scale Driver
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  Airoha SoC contains multiple subsystems that are scaled to a
> > +  specific OPP taking the CPU clock as reference. Such subsystem
> > +  can enter idle or performance state based on the system load
> > +  and power consumption conditions.
> > +
> > +  Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> > +  Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an7581-subsystem-scale
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  operating-points-v2:
> > +    description:
> > +      OPP table of the related subsystem supported rates that referenced
> > +      clocks will be scaled to.
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - operating-points-v2
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/en7523-clk.h>
> > +
> > +    npu_opp_table: opp-table-npu {
> > +        compatible = "operating-points-v2";
> > +
> > +        npu_low: opp-400000000 {
> > +           opp-hz = /bits/ 64 <400000000>;
> > +        };
> > +
> > +        npu_high: opp-720000000 {
> > +           opp-hz = /bits/ 64 <720000000>;
> > +        };
> > +    };
> > +
> > +    emi_opp_table: opp-table-emi {
> > +        compatible = "operating-points-v2";
> > +
> > +        emi_low: opp-400000000 {
> > +            opp-hz = /bits/ 64 <400000000>;
> > +        };
> > +
> > +        emi_high: opp-540000000 {
> > +           opp-hz = /bits/ 64 <540000000>;
> > +        };
> > +    };
> > +
> > +    bus_opp_table: opp-table-bus {
> > +        compatible = "operating-points-v2";
> > +
> > +        bus_low: opp-200000000 {
> > +           opp-hz = /bits/ 64 <200000000>;
> > +        };
> > +
> > +        bus_high: opp-300000000 {
> > +           opp-hz = /bits/ 64 <300000000>;
> > +        };
> > +    };
> > +
> > +    gsw_opp_table: opp-table-gsw {
> > +        compatible = "operating-points-v2";
> > +
> > +        gsw_low: opp-200000000 {
> > +            opp-hz = /bits/ 64 <200000000>;
> > +        };
> > +
> > +        gsw_high: opp-500000000 {
> > +           opp-hz = /bits/ 64 <500000000>;
> > +        };
> > +    };
> > +
> > +    npu-subsystem {
> > +        compatible = "airoha,an7581-subsystem-scale";
> > +        operating-points-v2 = <&npu_opp_table>;
> > +        clocks = <&scuclk EN7523_CLK_NPU>;
> > +    };
> > +
> > +    emi-subsystem {
> > +        compatible = "airoha,an7581-subsystem-scale";
> > +        operating-points-v2 = <&emi_opp_table>;
> > +        clocks = <&scuclk EN7523_CLK_EMI>;
> > +    };
> > +
> > +    bus-subsystem {
> > +        compatible = "airoha,an7581-subsystem-scale";
> > +        operating-points-v2 = <&bus_opp_table>;
> > +        clocks = <&scuclk EN7523_CLK_BUS>;
> > +    };
> > +
> > +    gsw-subsystem {
> > +        compatible = "airoha,an7581-subsystem-scale";
> > +        operating-points-v2 = <&gsw_opp_table>;
> > +        clocks = <&scuclk EN7523_CLK_GSW>;
> > +    };
> > --
> > 2.55.0
> >
