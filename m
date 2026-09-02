Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE93DAADD
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335561; cv=none; b=jXJugLHwdwwyOC5qEi5H9cqWFDCrwGF4oz6+vhCvNOp/Pr32sW0YyqA0ajYeTERaI4uKTUSmyqTb/8RrD86G68nMU74mBy3z2TSJ+RuFE692nyqvzuRo2XvGCfPL39GSdinpUZRxpCCQiCyChLiy4BhXnXQmTP/+CcPM/rIqdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335561; c=relaxed/simple;
	bh=vS/n6FpRvsfmcwxTkH9S/ll+Yj5BUUp5Nnnp42lgrTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX1qBIjYx7ewubNqnt31bsVIoySQ53/aFblmKS4lczX6wtzRVycySTSSYIVQB1HwjN0i47rN+2y9WVrDP3G6cCgbjDol83j4J4V9TvS9CROV5L0uwCBOezbSQeRj/H2nUXrandvB/qSlkR66SjSiz3DbMbYY/jG+Qebgm++x34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTy54Byw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGeolsm1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTy54Byw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGeolsm1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VSMI1451319
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 07:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzl3ufzAnU4HEYD54uRhJuX7P8cpp0TpUhmprYF889o=; b=jTy54BywqPTSFTKc
	e10Qd5SSwa9PnvhTAt1zP1ZQkTHhlG6wPONubZB4v6pvi83tQIvJsJosNTTjsYd0
	mZmaeefAc6KB8nKYtcCVjsyQuZb7nP1/pNgulX5vZcBCc9HGvTso/tOIPAmd+kKF
	KW/tZPufHJACpn+wID9h/eKFaMhMfZDiZncxeBvA17kTOYD5l5EYjnpIbjlAudbW
	2dl5ORNL/ZG83GGhOqa4/5ZUbUjavBDF9xRu+cIlNhMlbyI60Ospx5C+IiALoiOI
	N7N5haY+5kg4ueqbph1lGUMAIGXCaE9SeBqiStfqpgP6pdnq0yOwLejysdLh32R5
	3b4FSg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gebsx0wq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 07:52:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d932ef41c4so12167735ad.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788335556; x=1788940356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzl3ufzAnU4HEYD54uRhJuX7P8cpp0TpUhmprYF889o=;
        b=GGeolsm1BCZ9IBJgiv+7sv8cHwR/Ij7ukEERws7/6nuQVotcbOoTUfbc4rAcBgRza8
         Uf9+sNZ28J81eOqisn1jCOQMbpbm3Rqc7ucPYuVevbDBfAYjZqx6DGSqXUJdDSEjzdlv
         9HJafe6jlo54IXGyWkQpe10AeatmHh4W8ljSKl7Ts32zgY8jsBhh9By0+x4dgQHjEodP
         E74k2qcrhOFL6SjJb4fOjkqPlJhR/pzoYN2N1mxYo0ZlKqv8K2hywXGPoY2VXcVmzhLH
         PnEcJek0Gpole1mdvBlJGf8BrnQHxG8MxNTTAjGsxK+mujoZj5P8XSy1MACNSDsJSGti
         gjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788335556; x=1788940356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wzl3ufzAnU4HEYD54uRhJuX7P8cpp0TpUhmprYF889o=;
        b=HKnByxAJF8WTKy7MKTNYIGju/XFT+nFRBeJAyM6bWwbmfODXIGIANCD8XsVKTRpoK1
         5KHGeLeIu22ty3RsZAmHxWeER0nRuKvsySDMnh33a+R+4++oezhOCJrNYqIjWJ137Axt
         c+S1f6JdmZIqYn7XjzpRnoavbpS5UPuG//AoWPUlOZCBhjHciYg7A13Z/i+KtGSwIl7L
         7z4b2ZqaDuHOrz7oMyymq0XQ2a91yHXCyEoGm8uN/OI78YXbW7kpJU+j4eNBG4/WrOfV
         vXZPWQhWar62JLZ99FqSeYgTOx6yhS0JgT7gNYSFvEsnqUUm1ivJp+ZmpMtMX1HqngTC
         76EA==
X-Forwarded-Encrypted: i=1; AKwUvBwuo8HbSXdQq6xVZJ6xKiHctYNjANhX0KfM883uK8aGvGJesgfzYnLWRCxCUukk+bzPCTXq9CYK7g==@vger.kernel.org
X-Gm-Message-State: AFuF++nhtAYx1W71Jmb5ycZ0iO+SkhlAXSXQ1i6eDp9ICrhxtI1fcsqH
	nKF5V9g+Hq2YdKY2u/SVmWFmD1OcfT0I7wjHsqr2GVtk6mGpQEiCSUthNQyzXUShmb4x6RndPQy
	2b25BCsrG8xuvjUShvD/TrcxTNACjMh67VTpHOM+kgWG2nqD6tfRoUinjahtPVw==
X-Gm-Gg: AYBFou3YB9HXi4bdxSV0Rl/rADWdqOgfnTgRzkqNmKaXZZJv+jXXKs5qFDea/c24UNu
	UIyf4YcOpfNHUb5rn+R4e5Q6kqNltxhTArNv06RzlBmRRiqyzPidvkAkzHTH27XdWqPt1RO5F7p
	z58M5CVntKx+2r1d34Ou0F7Du+z3zVKzkGTZECBmwS6ekJFHOcduXpXaLAm/q9Kc+Z98XjDHq9H
	mj5ubDhVMk6dTzmMyPutcgoLKOnspN+FwqEZyPNbPWF2WF+SWEkvT/OC5jlYjrk5xY/f36eYtiA
	0oTHislurjoAwpUT/XxCLelqFIUxAvdsFWcwk0SCHZM4ettLU6ynL4zbk/6cujeCP7Eq2aUeRHm
	B9bAkQrWSDh6Z/YppACYezvaV/jwaMH0Bx//sbFLLITY=
X-Received: by 2002:a17:903:230b:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2daf13b31d8mr10641885ad.23.1788335556402;
        Wed, 02 Sep 2026 00:52:36 -0700 (PDT)
X-Received: by 2002:a17:903:230b:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2daf13b31d8mr10641525ad.23.1788335555939;
        Wed, 02 Sep 2026 00:52:35 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79898sm5004359eec.15.2026.09.02.00.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:52:35 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:52:29 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add NMXC power domain for Nord SoC
Message-ID: <apfVvXLAW0j7g3pD@QCOM-aGQu4IUr3Y>
References: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
 <CAPx+jO8RVUv=mqDZ-GeJa=dEYdNCK9L8Vi=UCDY9GqQ1TefCsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO8RVUv=mqDZ-GeJa=dEYdNCK9L8Vi=UCDY9GqQ1TefCsQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: A2K1RjxfsJPSNp1ZbafQcBCvidqkM_tk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA2OSBTYWx0ZWRfX2g0cG/llK/Pj
 cS0/DXXgu534Vg6D1mDD3TCCdZF9AHz3rCapcaIwhCBKNaCEzN53Sx9mz6RmuwxJ5R5quwatyWF
 loGnJNd9jz7uwD4GR5xg/ppF+SKViyGtdEhjuBYFDq2t/QEV2Xqvh615I5iopb/px+wQrgWneeG
 6ebRPnpEa4bkeS4zqS+jAU8UEV2uosjgcngzYULW+DnUlJwZA+k28q6drlVSLZSFhKYM7Lt2IwQ
 qy4y8xBR1tKbZbmkAcZiX16w9b8LHAQ36hoYJUGRRaEaBJ6AnlFd9BBMBh60srrzOFbxrYVD0/X
 WluaXlujyK2YaY5sMA+QsPC2fQfG+b+Z9oESSHvOOBDkRU5/SFGXvMoGWgbdlpVrOsmutM6dC2o
 BNw/yn02VKx2e4YCN/O9R95QJpTU6Ce936L3L8ezsN1uY/hTn+AI46WgrujY6tNspnD7g1qxdGB
 9PiwFOWb9ZBVQAEpiQA==
X-Proofpoint-GUID: A2K1RjxfsJPSNp1ZbafQcBCvidqkM_tk
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a97d5c5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aF_vd5NMXLjnXWj9f7cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA2OSBTYWx0ZWRfX6Zr2c6Orn1ig
 J4BApbDtEu9nSsk262N8nKE3Bhz0nqGV5bcSBj+cZbB6GeZNw/N9HLMWw33jkoO4NsyKNcDpY8H
 WAYfWt5fmxspugNMFSmSp3VldQKtP7c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020069

On Tue, Sep 01, 2026 at 05:46:09PM +0200, Ulf Hansson wrote:
> On Wed, Aug 26, 2026 at 3:55 PM Shawn Guo
> <shengchao.guo@oss.qualcomm.com> wrote:
> >
> > The Nord CDSP subsystems do not take their memory rail from the shared
> > MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
> > resource. Add the nmxc.lvl RPMh resource and register it in the Nord
> > power domain table.
> >
> > Changes for v2:
> > - Drop remoteproc changes since "mx" of remoteproc is just the name of
> >   memory rail input which can be wired up to NMXC power domain in DT
> > - Link to v1: https://lore.kernel.org/all/20260826102746.633076-1-shengchao.guo@oss.qualcomm.com/
> >
> > Anurag Pateriya (2):
> >   dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
> >   pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
> >
> >  drivers/pmdomain/qcom/rpmhpd.c          | 6 ++++++
> >  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
> >  2 files changed, 7 insertions(+)
> >
> 
> Applied for next, thanks!

Thank you, Ulf!

Could you maintain a immutable branch for qcom,rpmhpd.h patch? I have
dependant DTS patches planned, so an immutable branch would help Bjorn
to resolve the dependency.

Shawn
