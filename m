Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24F49EC7A
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601358; cv=pass; b=k3ViYnXE5yLHbm7iZMMzSJMmUpHDhYgfTJVBba36zgQwihBlbzLy99i0LNxWxVppTaR9OG/hbm/+2AG5kyaaR1sY3ZtwDdbkYNYS6cg5yVL3VL0Q6gux6oANZXiqAEETOG6J0Q7rnCAHJRgo6n8w6vcelVJ5PxUrAgHLaHofTkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601358; c=relaxed/simple;
	bh=RYNnodyGj2H4ZDL9Nl1Q9njPA0WoMAdmfxHZpNUl6v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiR/wxfURRxourxvQxwmRsDwNzVzwuNTYe0m2fEOaelxEyOMLH5nIMQi3A3UjYXVCDPAE73u5APZnoOSAcyWt1uikYzuNVakSCaoYPAGvrVbVXm3aJkWqVaQb7X23EIvFzmr/y3fslH7iYlMCCa+cWIEwgn14Sbq6yBBCFzDFCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbTp5OQb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gwzB9ILM; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbTp5OQb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwzB9ILM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAMZq558602
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N4n5cIJubYf0152q28FSh/pocYyVNa6tYRLNKG8jP7g=; b=XbTp5OQbKoXax8+1
	TbIP6VO4B0jP0m6BbYqkq48DBQBCjunQwA6pGwmTeLGH3Pj60TPsImezhof+zWfP
	/VsPH0cVPoEpWhcrK/R/cua0TmwJSNVSqdoLdRc9fT/IYhO8+Axt+7I3xeWol4Vo
	Prvzc+SSKnJbGNEhsJ80lxMyvdWfVFdsoRsuERJK74v5SBssh+8Y3dY4iM/7l7qt
	RQMd9Qxn1s3dM4O3zogtAR6OMsdrAXLGptIQRf4vquBT+ArIR/beCvPD2CAwuAqB
	8VRHA3ERN4sJCNat4XEmOZt2LcuL4da+zOZhjjzWeX2TfFjVMnlEUA3EZ4jcVCg5
	MAXutQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq298b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:15:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-877ef1457aeso2334757b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790601356; cv=none;
        d=google.com; s=arc-20260327;
        b=e0ifVkI/izL4k1iBPeD5L5UxethXCLatjuPw+zgev/ZZ8Ycha3wjW/iV1SFcjv292V
         kMWEGWSk++ZJvg8CLLLSs1IzSRW47s8eaetE2Apj25xKP7FEF8Sek9Lzwaf8bmLVh3Cc
         GeA5+9yuwx5xBtRYnswL50PHJkQ9ZFDPyVbfUoBf2UzqQkMzfHN6DfmHxpTpwZZ+Ygyi
         VTLt7zgXvXuJWjCXhN+FEXTW4edRdiOVEGlrhq/JFopGf4R2PzaBJFZiSsXB99tjJzp1
         xRCvQJ0PljmTheDjV1AYBYknmA0wVoWSR7jVo4Ry6eezkCiNOHNGEF4AUqwsViUprlXy
         /wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N4n5cIJubYf0152q28FSh/pocYyVNa6tYRLNKG8jP7g=;
        fh=d5esiCLIxjQs/QfIp/GdvkcohEB3z/cVXTSZXZBqs7U=;
        b=lYgwALdPZVf1ciSo1gB7eIX4dfRGaXEe3gphBvOZ3EWw4K2lnttlVAbna7OFnpBytS
         MgKTTK25+oC5ZLnQL3XYM7BlSY/9f/cz68Cg0DeooPn14cHxdg6pA6QiuBp2wU/GABbh
         Rp5iGQqpoWGqwTQLX8OdkM2VuEvkx5h6ZPRfOhenf6IGaAlQPqviK0WOkHxIOTMdbtsv
         /BeFd23OcgbtQZhn/S/MsmJCaXUb79gdZROkV6wq0ll2+bm1wABvZiTLGc5WNDgzD4z/
         4R5AfDSfU8FD7cADkQVCTGIqfZuaxWrzGVHFZmo3ToIJfAcnQhWm613MH/5LOm3opPc4
         9pRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790601356; x=1791206156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N4n5cIJubYf0152q28FSh/pocYyVNa6tYRLNKG8jP7g=;
        b=gwzB9ILMfzSoSOjJ08ZBSTSncUQt3BtTIaRrl/xccPwhqlQX/pL4mRumhw3OgDWNUu
         jgUe9C0AzrmJ8ECkiY3CJ4WENXiF+dJl4Ft0I+8445W9FQ5Y3KtcPbn2+C6q2zWhPw9D
         w8N1Lgon2n0jYOpWBLnPl2x5QlVKCPN2XS4bkKH8uTkke212+rKSGdfDvOAd/WrP0V0h
         D3faRoS8Zt+13pwONGvEvt4oBDMf3pO+Uldl01Q4MPJKLL7NYRVWZoREztcPgZXvRuN2
         surG55g0NDD35nEyR9Pxd4vixuxHPkpndfQHLD/j1qPY4RNoBg22b58R4rvA6JJJ4rtf
         aqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601356; x=1791206156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N4n5cIJubYf0152q28FSh/pocYyVNa6tYRLNKG8jP7g=;
        b=G+uJbQShrotcDhD+PC4a+XKjVWeESJwDqYNkGZkkVHRM/2xrkgGtiEBvbO1tdhOB0m
         3z3Jr0rVs8+EYfr8TGsHT2Nz9CGsqfI2E86Wipb9EyYO9hRzq0xk+JSs2AIbCn9Xh8qi
         3DOCqGc0oXe+dEyXkdRThocL9F/OMTcyVNNNZbHDjo2GbuYprWlh4OkSGzpsUWbCR044
         d1am68QlpTHvKN0wNj4w/bFFu2nHiDkmQbLI/yOYUjzIVT31QIlM0uaskVM4em0iMlmq
         sdqqMLlGzcUiPPHWHgas4tAqctUcNMoSOr0G/7yTWgchdqphxBFLSPb/APo2KgnMdqOj
         hXYg==
X-Forwarded-Encrypted: i=1; AKwUvByN2hP3wnT5vFNUCUTcqDqbpGHvudA0WDdzWNe5rJD9rw+TrzHrbhClpNdKPc3mQSZQ4YSUMJnkwg==@vger.kernel.org
X-Gm-Message-State: AFuF++mMgI492HhpuYUo1Ip5lkYh2oGy/nrUz13xSvxyPQZoRumpwlq1
	XJQ+ppYshJA7PQLU67ys5NyCfi/GQyDUZprBPzHSmgodY4a2ec1wQlprG6uIyRDxHSka11Dvr6A
	KI2IXx08wRIXQgj+fyNSuOUHqyWn6iupPTaUmZSx7J7ruigoQPbDtyxONGyOH5OJfN9fX5xfEVv
	rb/BFAZbg8HO/LRw5JlCdhsevK1CeZCmkPNKXZ
X-Gm-Gg: AYBFou1/yJ0enCvvp4yL7+f/3QmEZLx7fUlYhLWcARvXRBjKH/pWm+UQ8MCc+e6WLTC
	8e2eawUehRRqWwqXvoERjTZ/IjzO5+NQVKf7m3lvDZ12loKjmBP9YlGFuDBbe0i/dAOtbHLSj4l
	53FnWDJovVnJLzU5C9myFZiEJfKBsGFo2oaBkFDA8RF4lK6cCTugvBlYHb5Q==
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f640 with SMTP id d2e1a72fcca58-87e9b89660dmr9757095b3a.34.1790601355554;
        Mon, 28 Sep 2026 06:15:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f640 with SMTP id
 d2e1a72fcca58-87e9b89660dmr9757075b3a.34.1790601355104; Mon, 28 Sep 2026
 06:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923174711.1283986-1-briannorris@chromium.org>
 <20260923104031.v2.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
 <CAPx+jO_1qYnN37diVN1=PA0xGa0iSBfXD_uqgSdFpTn4t0zJiw@mail.gmail.com> <arVWVA3lks7SopQH@google.com>
In-Reply-To: <arVWVA3lks7SopQH@google.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:15:43 +0200
X-Gm-Features: AclHuK8aZhiycUM7FNAEkB4H-JU_VDrs399BqS11JuG1Exo3d6B2KC32ckC6HkA
Message-ID: <CAPx+jO_A684fd8SJML9NEmsGzNx2Ge3-mWyQcyjgGP2S5aX1jQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] PM: runtime: Misc improvements to runtime_pm.rst
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: quyd9TG6YscPVCJVe2nSTlmvIDrFuN9Q
X-Proofpoint-GUID: quyd9TG6YscPVCJVe2nSTlmvIDrFuN9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfX4Gf5FII/d5hG
 uE7PVvhXpDCxKE1TWmkbOP8k1F/FVNlUDHlBpWEZzwUq0okplO9+CMBbQgFwnX3tzQlgjR4ORLV
 39OQgQgYymZTXnsbt6lAme6EAK+jZAc=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba688c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=cm27Pg_UAAAA:8 a=cMkGN2WWBoTvdrordToA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MiBTYWx0ZWRfXyziwbBZNxB5X
 OyD998rMt96uuNmQwp4rHTNNSAhuojAwEGUVZ+X10wgrQtL7LgicFMziPk/WTcbt1nfIepXdGrP
 j6Raep0zMPwC21/HfHjB5Y2kfHOU0bfR3WbqJ2p8FVA0ap9aVwLmorXnvYjPbSSCdaHT15EqjTY
 6lMJxHckPXfItzgzSNwq1vBEIgAhZRyXQhXdlZe5lk09uK+Phe2kkkDgJRU8jL7HwCMnMOFPW5u
 fqPT0qHbcnFcJbeYBIjXXVbjD4hXxm5OsDht41nlf1fiBXpn2pcjQtsJjMBZoXrWA2bUIcjPGyR
 PHH8dELaM31y9iXltUHVFhPRG0PYMhIeRY91t3HplM3K8RRvHfYDnueWgmoNmfT4AAVdvc0/B/T
 SEQGbJiP/8dJv1boolyuqjQXpvG/rMtXNQ0fWkzxCb4ivrl9moObQ6RBP7bvmiVTNRaJuXCG+z8
 Xf5JmS0QUPBOjrvpvJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280052

On Thu, Sep 24, 2026 at 6:56=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Thu, Sep 24, 2026 at 04:01:00PM +0200, Ulf Hansson wrote:
> > On Wed, Sep 23, 2026 at 7:47=E2=80=AFPM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power=
/runtime_pm.rst
> > > index 39fdeeda7a1e..352cdaf0650d 100644
> > > --- a/Documentation/power/runtime_pm.rst
> > > +++ b/Documentation/power/runtime_pm.rst
>
> > > @@ -315,7 +319,10 @@ removal of their drivers.
> > >
> > >  Drivers in ->remove() callback should undo the runtime PM changes do=
ne
> > >  in ->probe(). Usually this means calling pm_runtime_disable(),
> > > -pm_runtime_dont_use_autosuspend() etc.
> > > +pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can us=
e
> > > +devm_pm_runtime_enable() during probe, which automatically takes car=
e of
> > > +calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() u=
pon driver
> > > +detachment.
> >
> > As I have stated in earlier discussions at LKML, the
> > devm_pm_runtime_enable() API is not entirely easy to use correctly by
> > drivers. It means that pm_runtime_disable() gets called at some point
> > *after* the ->remove() callback has been invoked, which can cause
> > problems, unless the driver's ->remove() callback has managed things
> > correctly.
>
> Yeah. And I think it's rare for drivers to have done a thorough job. A
> rare exception: I found commit 2d90ecdfa326 ("ASoC: rockchip: i2s: Use
> managed hclk and runtime PM cleanup") an interesting outlier -- it adds
> an additional devres teardown to power things off afterward.
>
> OTOH, between v1 and v2, I chose to tweak one of the Examples to avoid
> devm, precisely because it was committing (or hinting at) these kinds of
> mistakes.
>
> > My point is, the above makes it sounds like it's easy to switch to the
> > devm managed version, while it certainly isn't that straight forward.
>
> Right, I said as much in the cover letter too:
>
> (possible future work)
> <quote>
>  * Adjust the way devm_pm_runtime_enable() works, specifically for
>    remove()/teardown. Currently, this is very hard to use correctly --
>    some common driver patterns may assume that a device will tear down
>    while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
>    this makes some of the "Examples" section fairly tricky/subtle.
> </quote>

I think having some examples that *don't* use devm_pm_runtime_enable()
would make better sense, as it would show what is needed to take care
of things correctly.

Stating that there is devm_pm_runtime_enable() available would of
course be fine too, but in that context, I think we should point out
that the user really needs to address the ordering problems that get
introduced when using it.

>
> Would this be a good moment to pass this possibility by you? What if we
> taught the teardown to force a device back to RPM_SUSPENDED? Something
> like:
>
>     static void pm_runtime_disable_action(void *data)
>     {
>             pm_runtime_dont_use_autosuspend(data);
>             pm_runtime_disable(data);
>
>             // New code:
>             if (pm_runtime_status_suspended(data)) {
>                     int (*callback)(struct device *);
>                     int ret;
>
>                     callback =3D GET_CALLBACK(data, runtime_suspend);
>                     ret =3D callback ? callback(data) : 0;
>                     if (ret)
>                             return;
>
>                     pm_runtime_set_suspended(data);
>             }
>     }

pm_runtime_reinit() is already taking care of some of the above.

Moreover, we have pm_runtime_force_suspend(), which may fit well for
some cases, but not for all.

>
> > Not sure what that means for the documentation though. :-)
>
> Well, I don't feel like the part you quoted is a problem. IMO, it's
> totally fair to mention relevant APIs even if they're hard to use --
> there is no part of the runtime PM that is easy to use!

Right.

>
> But I'm definitely trying to make things easier too. Ideally, we can do
> something like the above to make it easier to use. But if we
> can't...well, I guess I can try to document pitfalls better -- possibly
> in the Examples section, or maybe an extra note in the above quoted
> area.
>
> Thanks for looking,
> Brian

Np, I will try to help the best I can. I certainly appreciate the work
you are doing here!

Kind regards
Uffe
