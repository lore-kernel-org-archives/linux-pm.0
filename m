Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2233002AB
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234733; cv=pass; b=kQMesffeuE3hLk2jujSPlayWCk6K3ErecZfMtwKhKlrZHCKusdNavc7E0j2UiuQ9h/8IppyMdgkx/3Hv62T+dL/RecPx/GoeMCWKfdIoz+81Yt5g/WFyIeJBX8ldeYVFS/J3vD6ZxZZvjPdTS1kjKcOnHVwQhUtmVMQbkokwTVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234733; c=relaxed/simple;
	bh=SlwrPGZk2tMiLQKxq283mBOQeeMJtKxGhEtF19KYueY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAR8OWx9oAu3bFSxcBDwslGeky8uJrn7VzQfXyxMnozytnOPr2E+rrrA3eZpafIN8kxpqRyxd4E/UKf//ns+2h/ac+Hy4inDKLz91+A3O4XuZcpH4Jy0ICLDXexxenabbt1TELSruijjVo9pkQ6J2pAOFuU3qKNiVqzkWmXxwW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmkCQTI1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsKc1ehf; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmkCQTI1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsKc1ehf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82kGD2275973
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 10:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HW7nK91TFv9fL78pEO66gVW1LSmg7sz4PPMdk8VtV1E=; b=HmkCQTI1v8O5o2wC
	UkT2ZsPDXdjoUqMnhp5DtTNZ+f9mApVcNX+kZgBFeE6J6QzGikSFIClPUNyLJm61
	PepCa5fsUZSgB7x26Q5mc2MXlI2RSZBN10nzactmj5qs0Vxm1Hj0kGG6QWME7tdk
	p4ElGhP1X1c0/wmjvLhMHc6+joHIqkpRfdSQy9hjTgJowKSoJidSfZRdw17SjoIm
	a6PtLyn1tttHEM/S9r2dFSlr521PstOJzaSLeqE/qRQ/YfSmFTNwFRUEwJcYtmP8
	+aS78gTFvg4Hx55ZcdX2hbNsIvYclgbMVSk2jtnHKl6Wdpige6rwhGh9gMSO3RVh
	viRn8Q==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsur93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 10:32:10 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eedabbefcso98636797b3.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 03:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785234730; cv=none;
        d=google.com; s=arc-20260327;
        b=oxDbv86T/M58jjC/kSML7YYJPUNsjYqauaLVYerKWMsaHeQvl/LDPrkvLQYvFPUOtC
         oq2EUe+3pUIC7rfjW0n2pm0Yn5WrNEBU6ZCmeWen9KFIq9OzeoZEeCG8Gbq9AVp/HTMd
         LfsPKXZqkHM0p9VB0nFZLr4gNn81dVyJOPDy7djCLPRwNiARUinAli5pN+hACtR+lppm
         7rPavZqkoxR0flpP83itoMSMw/MtCQhRVX/KQUHe54sh56oj55lGhLyjqI8K5ecR+HVd
         bH+cQmQdsoszlNBKQousO9HJyJNIDEWLXWmJiUMHIjlVMVVdQA5mFqZCAARTQrkMswpz
         PKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HW7nK91TFv9fL78pEO66gVW1LSmg7sz4PPMdk8VtV1E=;
        fh=JkhCOsXHD1pbzRANOHYL73khgiAIVNPPfWj1WEZldK8=;
        b=pg9eOHxAiXTNy+H9fey54kaJQWWCOLohBf8bYJrLn0gUXh+kK+1Gw3sVUxrBFX9GUt
         hYooxejKA2xWEt6Fq/cByh96E4qerX+QIRRV7T5K1hBcVJIeG8u60cwV7k0zu7eLCFbp
         2Yz9llj28ifbLS8lwR0NnCI73tYQgeJ288HjMVhfNbecamP0bcyJSZP71aAhfnCXj5jm
         +NxDZd8kyeZBGlIzMpA+UUW8w3iZA0Niojd3aLY5TIBG+NCm3J74R0tN5px6vwXSJOVA
         BYwA1TEMBUPqzdOYReENcSijRgWmp+MoVmrTsTE4DY4kKFsJmJqIhuM1ohcrJKs6Vl0w
         u6ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785234730; x=1785839530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HW7nK91TFv9fL78pEO66gVW1LSmg7sz4PPMdk8VtV1E=;
        b=PsKc1ehfujoqcyQrrkMYlPFLw7/4RDamn8zhFCLDGQmy5HPr/MLGnea366WOgNYNBB
         GVcRcLGNZ7TlUIGQT3LBoN6jnOfIUydjexxB+005ziAe/NQwnrAyPQ8GTNH8HUi0RnY5
         tS9rQZZL+71bdwO7IDvDXpJmX8FqlJape7ZB40da5DuSJM5cwPpSVnuCIV0jbrGg6mFO
         iD11pW1kjQoDxvlIdCLxPsQ4i1wu8N40aZRKbsdqP8XPYAf92I2agaZuwVxr3lfnDWId
         O40/ddGv6QkaB4K3FHx5f03/AaFUV3ymrojQlOhAyXbFsUNsthPdjfvmq1jrZSAquuLh
         fNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785234730; x=1785839530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HW7nK91TFv9fL78pEO66gVW1LSmg7sz4PPMdk8VtV1E=;
        b=sS8d/miHPseZkvhLL7Gta2oEt4Pg8IuYR3dC1f2AV/WfB/MwZegKuiSP1JrHl9J7W4
         FcmQtWX/9zdGXsZlcjL73bbY6Owqs1cYIuU93tUs6Mb/FBfCPHD9GROGotKd8YLJ+YHV
         v2pSy/jvpU3tdxx9+YvC+b+tY6YVO8tl8acn4/jcZlYLoUHkwBfGCJ9kGes1SxIvRR06
         kEQQy+8BOY7LQAegDHRIvoYOcJkJfTkJwC6A7ljgFrDZde0vtd/FxwY1H95OhKYsE/KY
         Gc1PMybAYWO5UFJjLsPC6dpTlvOWMWBqXSEXP5Q7aRX7oi2JhfCOg5Yxx2PcTiVyLarC
         SUfA==
X-Forwarded-Encrypted: i=1; AHgh+RqWIf+Rt/LmzN75X0MCB9bGlGvThyty3WTh6GQOvehY1+DdL+g0SG/c4jskaVeSF3vStLT0WrE+Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uot2OIMIQaM8S8vNWpBAPCLwWJTGT2zRZHIXAHfNqJv2rEeD
	qLqcHSjokQc+TVZqz/i/9vmFNjr+uxdRJBET/8BxYANJPTLofVR2pYsZGjy8o8Y8FHXHzsvlAzb
	gUpaY8S14l7k4Yly+T8HiUO7nDHLv/42cz4VmyXwOXe9aIc6QFQOcBGmpaohXUKlT1MspYStBb6
	wwmIisLbDG/AXNotbv47AgdZKiyO8ct6T3psr+
X-Gm-Gg: AR+sD10feUnK0aME2okfJa3VRY6aOivgLQJ9oYuwL/RjwzR5ebO9nLFkVvNORST/hGr
	w8PD2pdaT12ehTbOath9yIfEBSPaf4owl3jJd4LMQGXaCGnlZF1630wLMNv+C5qeI9e+XK64luv
	v+0xvXbQ9nm3hKFAqyzJI9iTyjcTYklWoKHOJuvC8KjV77pFxc9DgraYBgHA==
X-Received: by 2002:a05:690c:a98:b0:80c:85e5:875e with SMTP id 00721157ae682-81f9942cbb0mr7432697b3.71.1785234730107;
        Tue, 28 Jul 2026 03:32:10 -0700 (PDT)
X-Received: by 2002:a05:690c:a98:b0:80c:85e5:875e with SMTP id
 00721157ae682-81f9942cbb0mr7432467b3.71.1785234729554; Tue, 28 Jul 2026
 03:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <akfHIH_dZrr5bosu@J2N7QTR9R3> <f2d4b312-4a11-425e-8329-33838ed37d15@oss.qualcomm.com>
 <al9uRagYJSQPJr7_@J2N7QTR9R3.cambridge.arm.com> <20260721-wandering-romantic-buffalo-ebbc4f@sudeepholla>
In-Reply-To: <20260721-wandering-romantic-buffalo-ebbc4f@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 12:31:57 +0200
X-Gm-Features: AUfX_mx4FYBv0CDzLfSFCClFXJjPNUK_fqBRZnaSA4S674r4_XuDaeJlCBcbxE8
Message-ID: <CAPx+jO-t1fRrS=-ufM11DAchi4uAki6mnnkJ+qh=M1G-qs4c=g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MiBTYWx0ZWRfX5rhkPHkpjpMa
 vNO2q9qu2Bi8alWXiNsiCYcxrLV4HwSoXkzNt8MQjK48Ljxv2YA9gnk9gcQ1BLlB1geqq2ym9OR
 Ui+evAnuRVIb+l3vVe1vftGzMPZJowG9qnUYXyQECIgescg0rT4/PrEgQvepIckdwws2swwj24u
 /X2yF1tRjsTQgDsR52Y5q1N6rHJIYKF9aARncScx+ybi5UrYPbuw2n4bGyo/HdtQLwOFKFqjnbR
 Vi3HvESL7PNvg5lEiFHeAz5DJ+rGJw/AxDsiqLC7VIQPJpFud8PVNIJU9o0qssrjC0K/wJYsS2i
 zAHnv15hChkv9tlOHzgIDFNbUgVZVJuvnNtQFrceeZ1WpaSzwM2rEyXceowgN3UqPjUCmXFbEiy
 AU7ueWS5g0Gir9kUwG1ZlmtqVbgLNPCY3MD2c0Vt9RRAa7L9EZCFDOuq25Kwwe7ZQZ4I2AV3h8A
 aRavGERtr3gqtzyubDw==
X-Proofpoint-ORIG-GUID: 49ZWj81_0HjRleujotQodj8PTXjoQkH_
X-Proofpoint-GUID: 49ZWj81_0HjRleujotQodj8PTXjoQkH_
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a68852a cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=Th27373rO5TmSeHawX8A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MiBTYWx0ZWRfX3uFJ3EdfD+wm
 IckRTAhrDK6E6GxMl2goJ3cV2xHBTEuGTTFZzzSe5znJbnceYPpDa7wxJpLA0N3QBs5Cd+8/DTD
 U2adQ8ImkXEUDmpjQPmaVFjJYbGcQCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280092

On Tue, Jul 21, 2026 at 3:53=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Tue, Jul 21, 2026 at 02:04:05PM +0100, Mark Rutland wrote:
> > On Tue, Jul 21, 2026 at 12:29:54PM +0530, Sneh Mankad wrote:
> > > On 03-Jul-26 7:58 PM, Mark Rutland wrote:
> > > > On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> > >
> > > FW permits CPU0 disablement because it functions properly in regular =
run time.
> > > But there is an additional hardware constraint in above mentioned pla=
tforms, that
> > > suspend to ram has to be performed via boot CPU / CPU0. Due to this c=
onstraint,
> > > CPU0 is required to be online when suspend to ram is triggered.
> >
> > The PSCI spec doesn't permit that.
> >
> > Even if HW has that constraint, it's up to FW to hide that from the OS.
> >
> > [...]
> >
> > > > This is a platform-specific property, and it's possible to build a
> > > > kernel that boots on this platform and/or other platforms.
> > >
> > > Yes, but for that reason the config will only be enabled for SoCs tha=
t have this
> > > constraint, it will remain disabled for other SoCs.
> >
> > Please re-read what I said. A config option can't help if you have a
> > single kernel that supports multiple platforms.
> >
>
> +1
>
> > > As mentioned above, its not a FW bug. CPU0 is allowed to be disabled
> > > from FW and HW constraint is for suspend to ram to be performed on
> > > boot CPU.
> >
> > Please see my other reply at:
> >
> >   https://lore.kernel.org/linux-arm-kernel/al9tdvOxYb83zBxd@J2N7QTR9R3.=
cambridge.arm.com/T/#m872da3cc4ded3386dce92d4bd4bdf9c33d3e2d0b
> >
> > This is *definitely* a firmware bug.
> >
> > To be clear, I'm not saying we can't do something to address that, but
> > let's not pretend that this is compliant with the PSCI spec.
> >
>
> +1
>
> Just curious if CPU_OFF on this CPU0 returns DENIED or just proceeds and
> ends up with cpu and/or system hang ?

My apologies for side-stepping the discussion, I just wanted to share
that I have explored the exact same problem with other vendor's PSCI
implementations.

In fact, I think it would be interesting to see how many PSCI
implementations that really got this correct. :-)

That said, I think a DT property should be a generic PSCI DT property,
but then set for those platforms that need it.

Kind regards
Uffe
