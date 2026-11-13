Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592082;
	b=cko+r0IWnm+RAUy2mPBqgzOrHucnYtAGTjphAk8+RUtLQ3GF7HhcLVGTz95uwOJII++i
	 bh5sIdd20d8JuXl2gtbYp5oAQ1Yl/M1J2ogvbTS0niF4tNHTA808/W9K/nKDMliU2WY6k
	 4VkHfT/mzIYt1+gl2ycwC6SprzgZAfrIiaC8QaWzChr/QXTIK672nR6HvQrcYZPB4LFyi
	 xAE7ILQhX8wRBlJVtIJ14iat9nEDLZ7v06U8BIQ6wwdZn1ZrnLh1zS1ZYgxtBEIjdHeE5
	 /xxAgPGtv6bX9HKmQMB6d25Spq9jlKhTcdFe0+RbR9dPVTasyqOj+RP9AD0bzLKpLdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592082;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
	b=tk4y+8xIooi3nR571fmIIBETdULwvx5JHUIocIgHOtMWXn3V+WWb28vQ40xcwIzQiE+0
	 RPkyeDn/sdAIoBa7Kr/sxFMHPhOExa1WIVc+9brH/4RLiO+xKB3H7bAOo4vm4jc+N/bzo
	 6a54bmHF910v4jFtJZ5k4tJkeaTuFljYwH9hSXQGm+S5Wkh8sp8BsqxhPFzZzFy0Eb8eV
	 +QUYbvLUb2MEDGvor7j80p45H7wCXQ4ZizAGJtldf6an47K9unrLp/Tp3WGH5tqzXm+Z3
	 h0Fja8ZHcNkflE98O+CXfG3NlyTzLRPW+sUBLgfmQM+8k4u32NxtCZez07fsZNLYGWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ4DHfbe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0EVrriA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059B606CEC6
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3059B606CEC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ4DHfbe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0EVrriA
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRAGJ1076329
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=; b=UQ4DHfbertQuo5VT
	BxZj/K3jFfBkDAEPaBojSwCJlYcpw0G6QfBFjSlmE405V072a1GFuXhx8dps8MTB
	PbAh5uclUv2E06ayHhKY6ehgB6UBp0kwIZRflEYqwcxwiMFnSMAIIOwuCRs+3mcV
	9/R3tv6iYbO5t1kNJqzLWaCgSa3tLnlGYL5h62t3ykUdrRGrzyTHjKD+uh9r+mU/
	dG7krFlKScrfjGx6wBxff0KT4Kx/zjlWQV/hOIO5rtO5WMUk9C8QjZUzUFJHZn17
	bKQxk852B8nReDUO/HbMi2QDzzqbA2+LM6+bp+UKsj/gZbhOEDrafN70tJHAHqpo
	jfn6HA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0amvue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so1808875a91.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592080; cv=none;
        d=google.com; s=arc-20260327;
        b=Dj/kBB8TZ3o3w8pHSPYvl/pLE6t3cFw72GoS74pijoZelv/fwtoeU9lsU/1DKDt7cV
         yHsHG7mWVjwrcZROmfKysHb9JEL6+uf0dmJ56l7LzD7uDpfZpUqPhfaN21wCsYpbkX3W
         yRR9z2jnzmv+UMJXfKqfTvD02am3WePEwJohjOnhIkzK5+4WPtSdCl1co0GADRFRHlka
         ORXONejnOgjKjxqwO9T7aA7R37kWssIJG+7EgaLwVrdRve0ok3kIw8wUY05JoaYlaZ02
         XMJiYL352J3Y0/2xuIJPP+vRG7QvZXs8w+/x89A/x8/7Qp5hyz0beAkdvS9dysBnd+n+
         htMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        fh=KS7WcTThlDYcklQZ6vmXTdacoaEFSMYXxXqGbqj5gSc=;
        b=n7KZfmmQahwLCH5k3UvQ3NxsG15aGqfCIoGD3gzuvUhfVDJAoR/Tv6cy9Kwsl8Hue3
         z67yILpDj3UqMg0+hI6P/iGN8G5EBpEJtL0Z+u79y+Yc48wsuS7vn/+LuHo2TZwCt93+
         eDbRElQifCuiPHCcDM61BezOH+jZooCLAIkS7UzFrLG1858Ef79YNUtDaIbMy6PDDM6z
         KBf309NNrC+tUwHSyS/YFcEk+YBv8bmg/S9lX/epm7bGrRsyHx+io3FHAVJ/nDeHmt5k
         Xii7ApUpkJOxHzANnPa4ZdjY2udQkNzGU9RZMj5FXv4vFk+0Sr44WBUO7nTKT/pC1y8r
         XIMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592080; x=1795196880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        b=M0EVrriASVl4BEUn6glnS5ox3E0QgX6PjCKNlaqDj3ym8AQsQP/Gm8udCSFQt0kCw+
         ojh2802Sz7G7infVLgeh9vT+7+ibuFMUycMkc158kjYEM/38rIgRwjWNPnCOWnzREcWu
         4yFPtRBAfLdprTfsG4GWSeDrPqcB42qk2zsllrrMVSRCzfadNQzNm8NY6Uxo5Yx62IqQ
         rHqSkD5+fkB2G1ZAV19sTN8Rz/u3ykG1nYUDmSau4jUO9ED+xuDPOvfH3/a41UedMV0s
         HOkoS3b7Ll6B+QQaMQrM9/5ZkPpCYbAbad3hF/OLQtwMT56Fkx9KsC8XPxSznK/Pla70
         RYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592080; x=1795196880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        b=xrvxZ/ZWchTvridN6dfs58rp0+0iaxHu3DMxC1xokFvHSod6w3dc3GchZCXcSbB3YY
         TbVCiEPXOGJMJye6ZUzLbZtjEHbOTyyWn8P+rVwuulLuzgukpU1O6te0NEMeWpc942tw
         PYO0zn0A5pBJyCuN4pZS3UmZso3UI81LG3VeRJog8UuXKOVdYspbFWkcrqAOVFUtOtYF
         rQZvHZESF0vlVCLSMOrckIRR86hD9sgOYIsxG2nBDK/i39YJcEX/L5JSY3tfdTlRX5NM
         Q0UQUPrI/5EPmfdlFi4ELVHA9xLnXHJpZAzk88kO/GATiUpb/uOFzKHtOrQ93GBeEtO9
         /+pQ==
X-Forwarded-Encrypted: i=1; AL+hErFuqIn0xZ5h1QubuOEbkgSAeH6QELcAy+PQX/+oAQxZmsVoVDYzPSMkOkpDKBVpjAbDieSeLHHaMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dOZwcMoKUQjMd8j1shsywRdMLh3bd8/CrsKmqz/Gefk7UkX0L
	O98XzTDH0yA4BZmko7+9egRlxjeEujhMsRZs14v3BEqpG2alobRbkp4lpPee3BY8XlONDWwf+2z
	M/DEBIJNt8cmcANKdjPBawIS7tc+gPacG5vhG4gv3C6POstDqCwxeq4EXJMPBD0s2TQuzS/SGiW
	Obr+h8tZia6SLAm9HXQnb8JfHToJUNP48nCLsg
X-Gm-Gg: AYBFou19XuV7MFOrJU0pHq3J7bKbeTM0Bbtf2Ug6Ri0x1TuWuKg8F6QojJqmxixkleT
	gTxmTnMWLEZenTTor66+t3bpf04EebljfCKGf1yVRCq8aKudhvQ7f4qVNNipAlH/kQXXlfExHkm
	rQC77BtP+hAfnq+wHp8HFjtG4S8lell5pYegu1QTyiy9UuMHK4c1aaPuAP+w==
X-Received: by 2002:a17:90b:48ce:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b1b0a4e8aemr2984898a91.57.1794592079849;
        Fri, 13 Nov 2026 09:47:59 -0800 (PST)
X-Received: by 2002:a17:90b:48ce:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3b1b0a4e8aemr2984886a91.57.1794592079412; Fri, 13 Nov 2026
 09:47:59 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3> <20260731131002.142671-1-linux@jaseg.de>
In-Reply-To: <20260731131002.142671-1-linux@jaseg.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:48 +0100
X-Gm-Features: AclHuK_ZuwtIA029trmw5F8DdkesfBzk2SXLciir6o9jwwGKO1CXPCiGSeJhXdk
Message-ID: <CAPx+jO8DKyuNMEKCHyKzw5DS62U2Xu6mcL3BtitRwrYP0gad0A@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX0wAs1PJoaUDe
 ftNiI1EaEeKYQal5q4EzjD/3yYnkk4S7jK0K3bNa/ByxmFmU3jodPotSpOG96ZtJsD9nzL1Q8rq
 8+Ban615DVFHyxDIazbbQU6tcjumUdk=
X-Proofpoint-GUID: Ex0CECgISVyyPcoEGNQE0LIRDoe0z3bf
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af74d51 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ShrK26NZXz4ow7qFTikA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX3tdPnNa/LqjO
 4AFts6c80otV0ACCZeXaHpoUTWhxz+w+p842FOJdPt2JwPiKIP5Fydo5dpCFiZwJ4P6KyWg95O1
 rMc9jkvWIVQxvLzGVgSko5gof70y6PTLg67GVpiINhFHPFEolq4aae7vw3UC50tnLjaSSvR8ksJ
 Mc+T/hVTfkR+JvLKi8AgbRNYzPS7DXF0yzuUWhP4gmf+1+DGRAZBJCLntJlkbcR4OAT2Q+akiEF
 LLhlvXOO3ZzLPoMv94vVn5sl0zd3h64gPzxqJHhzL4AhZwVHyKn5ocnS6QJb6wqOD2Lka+Xb5mq
 suuaWXr5ad22HLk//gD3b0OimS2NcylqAoaoHz/IcJ+dVliWSYO71dYUe6MQyys5LHGrN53ofQR
 0rPXU/C5i+L/7JcYpY/SGtQL/eNoBDLuG33RFVMUaEPr12bDxKGauy70EoLMCTZzXGc9FTuWv8M
 DoMAE+kzTRZC8vmIl+w==
X-Proofpoint-ORIG-GUID: Ex0CECgISVyyPcoEGNQE0LIRDoe0z3bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

+ Loic

On Fri, Jul 31, 2026 at 3:10=E2=80=AFPM Jan Sebastian G=C3=B6tte <linux@jas=
eg.de> wrote:
>
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.
>
> Since genpd->dev is registered on the genpd provider bus, fw_devlink
> creates device links to it, and those are torn down asynchronously.
> Nothing made genpd_remove() wait for those teardowns, so the provider
> could free the memory backing genpd->dev while the queued workers still
> used it.
>
> This is reachable at boot on qrb2210, where the firmware rejects PC mode
> and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> causes the kernel to crash a few hundred ms into the boot.
>
> Call device_link_wait_removal() before dropping the final reference. All
> link removal work is queued from device_del(), via
> device_links_driver_cleanup() and device_links_purge(), which precedes
> genpd_free_data(), and flush_workqueue() waits for it to complete.
>
> Assisted-by: Claude:claude-5-opus
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd pro=
vider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

I decided to apply this patch as is, for fixes! Apologize for the delay!

Let's try to come back to this and see if there is a better long term
solution, along the lines of what Saravana suggested.

@Loic, if you have time, can you please have a go and see if $subject
patch solves the problem you are seeing as well [1]?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261020-cpuidl-psci-fix-v1-1-d8ab9ac3b56d@oss.=
qualcomm.com/






> ---
> v2: remove this note from the commit text.
>
> Note: This patch was LLM-assisted. I reproduced the issue and tested
> this patch on hardware, and I did my best to verify it by hand. However,
> I'm far from an expert in pmdomain, so YMMV.
>
>  drivers/pmdomain/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..4eeb980e5a40 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>
>  static void genpd_free_data(struct generic_pm_domain *genpd)
>  {
> +       /* Pending device link removals still reference genpd->dev. */
> +       device_link_wait_removal();
> +
>         put_device(&genpd->dev);
>         if (genpd->device_id !=3D -ENXIO)
>                 ida_free(&genpd_ida, genpd->device_id);
> --
> 2.53.0
>
