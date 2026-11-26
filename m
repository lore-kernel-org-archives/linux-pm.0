Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699710;
	b=YccVt8fEysSdhqocLTwqj+Jq9J3EhmnKlwDCk+NDeMwUTrDsX/kyyTmigpIRYbT5jFc8
	 ubrqb7PHmFCQeVyGN0FJUUtv38ow0KrEbV52oaoKTPOJUdMPF9WfTTCOVvbzBqqrW5wW7
	 rcI1uCgjbEIc+w68PpNcpuKEmqOlP4ZBYoxv9oBT9F2zkeQc0MaJNkJtfCV8aQSLihEKw
	 JPAO1gEtwFzqJyYNrPO+y4EeqTx3F3a+jf6jXvbk8RQyWAndXvvOl5f26sfewjBGN0Frn
	 8lA8dYIbRqglSZ7n09JEdCIJItL5ncffvVXVDfFVGv7bvrV80yZMDa5gk/Qgrd4JIxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699710;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1+I6fHMDuPRbKnrDXPojoIz2V9mnQ+E25HZfyDXGVP8=;
	b=4JCVJ/720N/mx280dLfohHG2KC2wNOmQmlR8wQSyLb87EwRElg089TQyxfeXCyW7g003
	 wwPjpcY3EhyfCC3IzYQfuHDJ98uPTWglWU/BidS5f/PNUrCAzjhBRvEdb9/qtv1u9QxB3
	 IgR5TywDGJFHQD739pBZM+Mg07ex97F7UC55wlXqDEb4KCd+OiZdYNJtv3zAn9Xfnndaw
	 ycAmeexS64mXG0bzenaVXsFmGe/z0+xzEA5Fvt+oYJXgsKb9s8msJoFuAq3tgds2Z2LIG
	 iee3n+oraiZXYm2+IHn32qAHNOmxdVLClimPDxcm5VcnLHiOg8MBksFBZiVl/uZMMug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jeqcw3t6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VN6tOihf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3C606A321
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A3C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jeqcw3t6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VN6tOihf
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVU7Q4128748
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+I6fHMDuPRbKnrDXPojoIz2V9mnQ+E25HZfyDXGVP8=; b=Jeqcw3t6sCzKEA5S
	7m1Hu1eZRvWLVR8yKNZ0lsPUJWNMLz9Gtz1/kEdN5Mt3JMWd44c7PuQ4a2U+NIsy
	vIhlYkk/meL+McV3PyPWxdLqrwQpvjmsBCu2PCPfI4lYm6+Jxi1/G4YIMn1LEEwZ
	7Icd+2KYEcmzQPgqSthYEObrkVsSZ90EmnEweTDzHXdIUV/lmhueCzzoNnKCNf+U
	l8ZEz+YkwIoSD8CnfIerj2aP29GoHgdzU0AGy4LEOCT/3xQn73FZF4XGpeaSlhhN
	OsIuT2YPW2Nvgrzry5Kd82daet6ntXWkJxwz9viduff1ieJKWsM0l9yAKNrk/q9e
	IUQ7Hw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vav3je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:28:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3b4208826so4983462a91.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699708; cv=none;
        d=google.com; s=arc-20260327;
        b=hdqZC6uJBzbsiCmF3scI8dBx2y79TKBdYcahMiIRc8o8sKjwYyLPu7r14evNUOPmku
         pgbCyuFcYmSejfafvZfNgM+CDiaU0jVaOi61gZXXspox22q7BE237TauGLsq1TOF1Crg
         8DknRLR38S5yYV7x8zqj9pDs8yL0EqvHLMTCwEiiIbwiAC8JRXm/2baZ4UIMXNEnQP9A
         T/kuyDmmh3JR+CF+LcC2hHnbkQQ5xbf4yjJki8OzkBAfdVwPCtSjzjXFP+tL6Ozg0CBW
         UzL4X/Yv5JZPOGXFjq7Y2SZ+aF8g6gzl1bIkpSkZdhR0ZTOgStHZLvmroyHWnLGm1GnE
         wpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1+I6fHMDuPRbKnrDXPojoIz2V9mnQ+E25HZfyDXGVP8=;
        fh=CG1AwK0l5wIS9W42+/yEhkZAjb9JUrsv5gTq0jEKT0U=;
        b=UNesr2IhuGTAqaYWNyAMZ/77SFzVkNju7bKZKvBPxj/+ZFcO9oa3TnZqgw+tosmBfe
         RYw7eku47QfjSQ6JJKrK5TIZnqJd2cMZYL9UDXief+M84e0XyY9tm6pyFGddj1ucmoEz
         Z9MUGClRQLDHrQHEQ0MJrO32GffFOemnPy2O8C9KoCdMK1KS/wiiqbO4KZ1zptpOhezJ
         pOnf6qZXqL3hRyOOLotEDNZqcIyv6yUYNxZjMZmHxWdAWwDoC9US9a15/Wlo0xJpK9fG
         84UgWsdpMQ6Lz2rNDBwqUta8PHVShG5/90+NHV6248I4ozGgb/PCxKg++Rg2l8tcf4fc
         cR3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699708; x=1796304508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+I6fHMDuPRbKnrDXPojoIz2V9mnQ+E25HZfyDXGVP8=;
        b=VN6tOihflp+SHVp9SHC7JikYazTgw13123KrIf2ByS2UnyU7QdE99mAXYG0evdSYTf
         pGkof1aZfxMmagyDaGFrgtacN3lnFyGPh4s34EbEjzmPcbNjhzldDLyPEGneFWvzXhRf
         7E5QgNSPnPMnedBzHBNf6Iw5yyDb2eYo9YW5zfny7FyNBgm8pZmAyYgJuu97VCefYz1Q
         a3SS4XMXjzE2w1sbyoIyGeoDY5cCy58Ov4a8gD6de+BbsB9JpRAlhP8pcQqkBG6QLZzs
         2xlGcUK8vhCm6a6zf1XkUNMDp8nsD7vif8PjVmLTZulrCHy1XoC/RSjlSBVZ89BCiAb9
         Jauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699708; x=1796304508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+I6fHMDuPRbKnrDXPojoIz2V9mnQ+E25HZfyDXGVP8=;
        b=WCip/fYMkushQxiclhLKnqWkFx0tRuMrZ9/TzLIRG74VJAQsPU6OjnlBuSIB36HHhj
         /ah0qW+VquxbxF0MKZ8OxUbgYA9B7iNs7bpiozk7ZenvcKi8maEE9jDHIJ1HSy9/ezlh
         xeOzATow8mEo53qTwamv4cBYXiByrGsU4HhXNJXjGUc4JW6mfFJlXy7/bhF8DeuJKMGq
         89FmRH6rzXpkZlspM1UD7kRM2izf2m9Artq25fsV8zbI1T6zbSAAo9pXg/QnQFfcP0Zo
         PyuVMoHbG9OGAi5lnNAEp0HBNkNMWfsstMLc0h991Ktdstlw3efF0z8kRhEjT/qczQiw
         /rqw==
X-Gm-Message-State: APuU4Z8Y7Q0qfxgA1KlEI+n1v5uhJSgDN/hO0INb0v/YeR8bheWflb9o
	9chmW5IwQ/7tB4mBDho3VlStoSZHRbniyYACs2CviTAljx1DOokhh3hx8MP5kPjVHnarlho3fVg
	pc+WLG068aBT+aoYsazah6umKuXv/t6A7zIW5cPtSk0kMwDZp8sIOq4vONu9ihtcwaq5TkIroTW
	baG27yrztrc+F6SbPbTp2sLs61aJGfdCORNyUM
X-Gm-Gg: AZFdTZfigjAFtbC4LDAzRfW/w+lgJ6bNRivAqn4XpB4COSiBsa4wS4qdtDhsaIqmW6q
	H1gb0nFpA8Wh0TY9K5y/XGtB+x9LD8i9Xj64iXea8FqcrHpWbk1rlnw/oLP7fyZ1gJEjFZmuKMM
	2rSmp3GIErH4zfRS007QhHxt59lZOgcLCTxBvVq+NaepzndeKVpVQYvtxPJw==
X-Received: by 2002:a17:90b:4e8c:b0:3b0:99f8:72f4 with SMTP id 98e67ed59e1d1-3b40a5ddc20mr17103190a91.23.1795699707508;
        Thu, 26 Nov 2026 05:28:27 -0800 (PST)
X-Received: by 2002:a17:90b:4e8c:b0:3b0:99f8:72f4 with SMTP id
 98e67ed59e1d1-3b40a5ddc20mr17103161a91.23.1795699706928; Thu, 26 Nov 2026
 05:28:26 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4779892.LvFx2qVVIh@rafael.j.wysocki> <CAPx+jO8d-25kLQw9X0wW4i3YV4Jn+2Zr7_ZOT9rE10D99kPU_Q@mail.gmail.com>
 <CAJZ5v0j5M7fax8_XP1G4oENykq6vg-hgiW4JPaqf=AvRiY-xFA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j5M7fax8_XP1G4oENykq6vg-hgiW4JPaqf=AvRiY-xFA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:28:15 +0100
X-Gm-Features: Aa3M54osf1Ltqb35tf2iD0aVrSfLOXZ5vwQSyn4Tud5SI8CTusSvx9qN5agwOyw
Message-ID: <CAPx+jO--Nzeh+vv0g_sZXxXehLU1hv-O1MbA_wsRj5oHUZK7aA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: runtime: Fix issues related to autosuspend
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfXyG3N8WSUMjWv
 XkYPc1u0d7VWdBZecJU052moIPKbeEqECrw5xXiIthZYrF+Nbb4SgqG4M05W/LSrX5oIhnGUN6k
 bi4sXWL5id489YdM/b8N8NQnSnRZEKw=
X-Proofpoint-ORIG-GUID: Nb-q32bSNJLE_urWzNKhEtEGBqP2VYiY
X-Proofpoint-GUID: Nb-q32bSNJLE_urWzNKhEtEGBqP2VYiY
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0833fc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SvWRspn6cuzICisoxksA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX7AkL4oJxaJ3/
 nlLh/ro5i13wzcTwZaZKk8LUMR+nrjrhg4f6kZuQ+1Ni0uMJiXKmpF4HT12vqttpz9J4Tc6HLz+
 EPpY1RqlHOTfTYm8E/prglz/t9gChLQ566ow4HY9WGXYVvjE5BvogMWaASKkRliqW/qLnFq72oY
 xtEENV3BP0nqlg3rq4of2bg3j1OinyTulbSceOgZYeLVw3M3DkOYlY0/WB/ao8Tq3S6SLqJcH3o
 xV/cDEIUwjQrZov3lh0pXxpivat2eKJv/SGkW8zCxh0QHK2uHj7Cc9WvDVZqDKnvbSqs3kV/FIt
 gJUQEcLpBAXkpj/yQR6Ny4ErNPkEo1YL7yDWaN66L3R7kQt0zaIK8Rd9iZKVjbWi1TGkJck39ab
 MEkhXzhiK4ztiDPaXaOqDwBTP6BtDVK1ufZs5J5WgJ+vW4G8Ro+COFVd970sXvRqRlRckljMr+d
 ceWgjpH571dD8lUuQLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Thu, Nov 26, 2026 at 1:51=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Nov 26, 2026 at 12:51=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Nov 24, 2026 at 4:40=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > Hi All,
> > >
> > > This is a follow-up series for
> > >
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?h=3Dlinux-next&id=3D26236a3e8803f7e1ace104020d7f006edb220116
> > >
> > > which is in linux-next and it replaces
> > >
> > > https://lore.kernel.org/linux-pm/3076901.e9J7NaK4W3@rafael.j.wysocki/
> > >
> > > (hence v2).
> > >
> > > First of all, there is a potential issue with respecting autosuspend =
delays
> > > in pm_runtime_put_autosuspend() and pm_runtime_put_sync_autosuspend()=
 that
> > > existed before the above commit, which is addressed in the first patc=
h,
> > > and that fix is relevant for the other patches in the series.
> > >
> > > Second, the commit above overlooked some cases in which a running aut=
osuspend
> > > timer may trigger between dropping a runtime PM reference to a device=
 and
> > > updating its last_busy timestamp, which may cause the device to suspe=
nd
> > > without respecting its autosuspend delay.  Those cases are addressed =
by
> > > the second patch.
> > >
> > > Next, I was mistaken when I wrote this in the changelog of the above =
commit:
> > >
> > >  Updating the last_busy timestamp when rpm_idle() returns an error
> > >  without calling rpm_suspend() is not useful because the device is th=
en
> > >  going to remain active for an unknown amount of time and its autosus=
pend
> > >  delay needs to take effect later.
> > >
> > > There actually is a reason for doing this which is that an autosuspen=
d timer
> > > (left behind by an intermediate runtime resume) may be running when r=
pm_idle()
> > > runs and that autosuspend timer needs to be prevented from using a so=
on-to-be-stale
> > > last_busy timestamp value.  That is addressed by the 3rd patch.
> > >
> > > Finally, the last patch updates a kerneldoc comment that has become o=
utdated after
> > > the commit above.
> > >
> > > For details, please see the patch changelogs.
> > >
> > > Thanks!
> > >
> > >
> > >
> >
> > Again, thanks for working on this! For the series, please add:
> >
> > Reviewed-by: Ulf Hansson <ulfh@kernel.org>
>
> Thank you!
>
> > As somewhat also proven by the subject $series, there are some churns
> > that we need to deal with in regards to the intermediate rpm_idle()
> > phase. I am wondering if it perhaps may be the time to consider
> > removing it altogether, unless we still think it's useful of course.
>
> I don't think that the rpm_idle() phase is super-useful.
>
> Of course, eliminating it would require getting rid of the runtime
> idle callbacks in the first place, but we all seem to agree that this
> should be doable and probably worth doing.

Okay, agreed!

>
> > In the past we have discussed introducing support for *multiple* (a
> > dynamical amount based on what the device supports) low power states
> > to runtime PM. When I started looking into how to implement it, I
> > stumbled over the rpm_idle() thing, which kind of prevented me from
> > moving forward at that point.
> >
> > What do you think?
>
> Here I have some doubts.
>
> I'm not sure if there is a single model covering multiple idle states
> that can be applied to every device in every system.
>
> There are different semantics and different requirements.  For
> example, you may consider "clock gate" and "power gate" states for
> some devices, such that a device needs to go to "clock gate" first and
> then to "power gate".  On the way back, it would need to go to "clock
> gate" before reaching full power.  However, this is not how PCI or
> ACPI PM works: There you can go from shallower to deeper, but to go
> the other way around you need to transition straight to full power.

I fully agree and honestly it's been a while since I thought about this.

In principle we would need something that is flexible enough to allow
us to support all the different devices and use cases. It's not a
straightforward thing, but removing rpm_idle() is probably going to
make it a bit easier, I think.

Kind regards
Uffe
