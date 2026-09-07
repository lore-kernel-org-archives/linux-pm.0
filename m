Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82846984A
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785462; cv=pass; b=Rr6Fuo9I6+6JjwTV8C074bNYJAmbTHXOv/jBUnxGOODtfbpp/8ILlD+L6lMRIjo9R7uoDq0FFD11ToU7A35To8zmBKmD0UtdgltOsNYSz50tEtm4QwvFw6/cnbct/pgGhKjTTi9TqLFFHO4V2zaAeYULn17VC+UzlJQE0/Mpdy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785462; c=relaxed/simple;
	bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLaZtmoxr+9gMywHxMkB7Sz7E3xDWOFqnATadTrNRIXSQ2KVa6wGoLAreXDBZDAtSlklr3DUrmX3uvQwV1EoQRq+hY2SkBpeoI+JZjpVRA0Tn9OYhlvFd9v4BZjhDN+Fz+KKTr+Wf+HCPRIAiG83C0x2lb48Igo5enFnAWhjSxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U04jKatk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7S/LEd5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U04jKatk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7S/LEd5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687An5Mp3230511
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 12:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=; b=U04jKatkX5/Of0Lk
	NmSq95IrJaz5jcdpR2S3y2CdjZZrtZ5yoWV23Nl9G6UoLVXFr5aJFDMsoJi9WX0I
	nscIDNxtlNflYhFNPAXMWADWfbhGH4jyE+UTB9K4qxcPXD49SSYVfWcrjguxeEIT
	5YxVZHRqY0IiHKiufD+oEu3sQ692rdNZR0iwB2iLAudyyGRUXah+yzW/eGC/j5GV
	OpNpHAZsAMwSdDV1TDRFnU/WVuXH2wSDuQRWd50xY5EagiCkjIaZj703b4cFmVsP
	v0sXaSQuO7cUCRLl/3/CJmTrcuN6JvGiwTM4bqVg0Ec4ccJogB1oAkJj0fPshJKx
	ZHO2kA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxktrua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 12:50:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90ceabcd64aso79437066d6.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788785458; cv=none;
        d=google.com; s=arc-20260327;
        b=lYIycfhw120D+FZDGC/dXcwCXHgJzQmg6w7PuG9XqIZPA3uZvaQx2j/8v4tHq0UPL+
         gAdnlSxl0l30MaI6CA+kmQGgho0YO3Zf2ppOnsXSr+hCewuEVQeN5l8nrJ3ywfCTUYQr
         2+2JrhgPdKUV9z7NNazxJ/rZ1LQzgnXofnn0qHwi4RkCxuAKzIJagXWoKJUzFeIAQ9jw
         ez9WBMtR+IRhH/JjOG1YmnZ07rqXwFZhhrnJJr/ADp+QY/a5aPCQguGZIXtFUFRr7dYP
         Km1R9FK6IKVPS6XwEXMcreOuhtjoHWphvwKOKsIrYaYopDZ33DyrFtCmDpgtYoMq1LCe
         L5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        fh=aIqVJK11tLZqyLL1+kFAwu1rDghrh9+2OSzqwUR2Gzk=;
        b=Spo8fHmPzisjlyGeUIJMFedKe1DBFckOSl39EhGzwH2uvd/TrQcr3Q75SgHHntbkuM
         ooAECi/OTxySJ++tX9LKCc2S8KAymIbM1cQoDknaoJbD/o7MZ9+rssT7otW3czrhiCQs
         6qZdy0wS7IoWOv9OEzHGjSGZo11j9VmPsUEBmjTr6TNULb6RbyvdP/L/HXON6sErryEy
         /2QMCgL5gejzwHdFSWC5y+LpkCl9+FX09IPjCVgCetksVKjfJXz/tpyalE07twdD900M
         brntI78ta1pYa4lqo5f8C5hRgQ3/r1AkFPtmtubUjPLyg4JX4IZaGFCZH2K8Ac31w+PL
         9mFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788785458; x=1789390258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=D7S/LEd5tfmtAEoVBVUlbGFPQU6VKZUF6Je2YKaHzboMgG4c99XlJi2XdYmYUTlbFV
         2jcTK3II3F5K7p3rCXJWuLbI23ZM/zO4YMK1gF9S98VsFnH9njBf9UL3qWHYCDrC/iQ1
         P8KcfZ2fjjnCiuRCybfFhjBvFTifik1vvY70WK7D4A0dSmotItmcUZ2jaIxZTkqcH+cI
         ry4v9QNHbBpTXQGV1d6qic2TEaPCOCzgTIgVv1e80EnheXyqK2M+eegseltrbo8kVYvN
         yVWdPTTYKtR1xBSXGe0YDdvv6hpftT+suysydKLOpr0WFpUIcKyWHWH19noPraGnXB8j
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785458; x=1789390258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=AlKsBcJtfO2ytOpKqbuWiIFsBCikSsQ4pfsEUK1T7c8fB9uFFYodbSctS6FS1uHACr
         jVVRkmQB+r6ZrJK5hnuYbN/4pd4uJtbFAXBZ7Ktahbjfe0p4BnGEzdq3xI1PPMechGAF
         JYXEMYYjE2fUM9aWdjI4WPW8fz66wIyEJ/gIwXOxaidu2WITWku8iYtmgdDMEXFyk67w
         /om0hRrhkDpwNPMHAghXbtSURFhJpcucMjQP7gpKF9HApGPRwO2/ciIm5hHhM46heIvg
         li11454WsM7pM+L/kW225ThPXTxek+SjOnozCgRpPdP4o/wfB/JUPeb4z9qQx/Gac3uZ
         2zqw==
X-Forwarded-Encrypted: i=1; AKwUvBx2CoRngqkaf3n8KEMV94wcRYvgwR4ZWTO44nSOfXD6iqT4h7SJzaUdJDL2CzRGmWjphLgCb7IOSw==@vger.kernel.org
X-Gm-Message-State: AFuF++kRAUFkx5xLC0kA34xdZhngnsUq72vhLvbHqS5XyBvjb/3QpP5i
	Ryy6cg6HpcthPbj+Gc1t2XR9XmYs+neuP4/xE9iWOymTmhVP/RkhFLpJcGX7hFoyEPOV/iPliA2
	dOscYmEedwmFFJh668hv4l0XObteTyY/tT5gpVvR5/SJ9WpDHw8gKAygdW3QzhL2t8tI0NlFI3e
	AlhzEam4e6KnM2XbSJLWD3bbdy+KosTSZSMQtD
X-Gm-Gg: AYBFou1RVneZN7HKviVVaMLL4XdjY3pV9PNAyUfUi0A/jNOyyy4C/oZ+rjiohjQfgxj
	V8zOLGcJ6DHuuDsdlqtL9Srqv9ybYmneSf3NyPWz9W5x6cSe+hphTnbCPTmYcP7uFha+0DEimJs
	19w/G5pAUAvm6Pkysm9DcmzGbPU+DyDOwO53VTs6x/v5llKAQDZtAF6E6ALB/qR1IYUnkZlpjDQ
	UjD5OlDF6FG1ci9ImolyTYQhfWsrAnrN8Bt8M27rJbE8Yr5R/kT+D0eInys7wjyIa4d3UzDog4=
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id 6a1803df08f44-9103efbc676mr253793556d6.16.1788785458371;
        Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id
 6a1803df08f44-9103efbc676mr253793026d6.16.1788785457864; Mon, 07 Sep 2026
 05:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com> <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
In-Reply-To: <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:50:45 +0200
X-Gm-Features: AcwNN1Uy8Dv_z6eHdNiSSHvTLy1MMXc0Rh3LRZ3dI-XaUt9s5OrddNB4Kn5BgT8
Message-ID: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfXwBtbSywXMuMw
 ydRfYlNxxCxBHyQDuFK98zows7+8Ac64t7a4Fiw2Y5+4B1oNcyFOfh4N/mmbRYbBPXFQKKP0CM/
 zsz0RmQKiq/Z5dFID+4oTz2MAmmgZYUxaILgLxQ1LaDTLqKXV8xroWhJ/XOGtWDxfgZj+p+BYgl
 z1tN0ROWzKkIVbvZUrMo64I0EqMgFs47w7tlC+AVHjRhb1+qATHDHJqWkRyb+1FauS02773gqD9
 4E21BGdByzcPw2PbbiTMskNPdFP+cmriAPqDlDvZ+WSJ5RtQejmxaYXsQhCPD7yk60EEgMyBa6y
 2EMCeM4CKmCyAkPMSeqdYI29sBTYH3OT5pIPn+h5WoqME+REgoUU9GbxvxaoG+ou3R//2+lXPhE
 jW4t3VqErlSBb1vyn0mv7tnVfNQyK41508FstpQ1R8ysGTGroTPjxjQeXOWgNd0uaY7E0CfXdJ9
 uA+lnoQTgfoGZhgQ1xw==
X-Proofpoint-GUID: Hd708nDE2QwAY0y1Go5FG8u0u71jpXNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfX6JEuWJtM+PUL
 +1u5jsufOWpcYvy5eNA6BbtI08vLLMhW1oa8OgfTlQsa9ZDp9KdYwaS5qDWj/DtUs1AWwqe7p1w
 4q6LS0uGsh0xprtIB/6WwFbby0goFF8=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9eb333 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YKo8iWYt6ehE2M1v1KUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Hd708nDE2QwAY0y1Go5FG8u0u71jpXNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070142

Hi Bartosz,

On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > This series describes support for the onboard WiFi/Bluetooth module
> > present on the Arduino VENTUNO Q (monaco) platform.
> >
> > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > these pads are populated with an NFA725B module featuring the
> > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > the design is functionally compatible with the M.2 Key E.
> >
> > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > signals, as defined by the M.2 specification and handled here via
> > the pcie-m2 power sequencer.
> >
> > This series models the hardware using the existing pwrseq framework
> > and connector bindings, allowing coordinated PCIe and UART bring-up.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> What is the merge strategy? Do the pwrseq changes depend on first two blu=
etooth
> patches (I don't think so)? Can they go onto an immutable branch shared w=
ith
> the BT tree?

The pwrseq changes are only a dependency for the Bluetooth changes,
not the other way around. So yes, they can potentially go separately.

Regards,
Loic
