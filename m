Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4364CE66A;
	Tue, 15 Sep 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500325; cv=none; b=aPpY5iM0g3YcKadmsrIxQU4/Lmh7MsxihA6dYR+DNT59Y2ZVxpgHQ3Rq3I8g+bfr6eqXbePOT0QBL5Vqk+m1CJdIDCGG/Sz3EMWhijtwzsoDcETGzjR98X1MVRb2H1thAv3uipx+J9xamPXDUigeEgW3CTLRbWe6JPsQAK8uhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500325; c=relaxed/simple;
	bh=wSWL7biVBvzK7BJ/753cBEKcMB0azvZH12D3W7WWFCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6mx2tvqpC6C1JKL+OjzxBDEsWyH2tff4/VPdqWHQ02IJq5OiCw3ebQqLbC2E1khWPIB2nNmcBRiMzWbj9kEt2bGrDKzIIFrG8tIIKTSjidgfoesIyHryITVft3saLr5s/TRRZxc+vhuIXdkP303/A61zqkOg4n5Jhrn/VDuGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SK+iVnqL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SK+iVnqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789500311; x=1790105111; i=w_armin@gmx.de;
	bh=BBkYGmi94I4D7FYZrnZnY+yxsH4qY8YyvYy557xoJr0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SK+iVnqLyhnVYWWmTALCfIXOGvjeKPamEqIFd7Sh2DbsUzIknPprsZE4oWd+y0be
	 wbfy8R8yJrNi1gpTmnT+/UNwnv75Yr6UiSZ7a0PuOfo6BCsLjhM9Qre7uSEuZ+t5q
	 gOjR6pS1rc7puVvcqQDHB4yi8mdf8vzVRqhHjpSAk184tX45YLJkhhbLM2wL67+dE
	 jp64gxP9cx1ZbckWJ/YOFNQpD+PKnF6dpwFMP5TNkxy4C0/3vu7aswdIH6vYckwEi
	 CjInmWoGgxRsgc59eJCLKZEKt30wxyPXlsUjspIIUdpApB9QN2l4AENRUAwNTTt60
	 G0BzBlHnfrQWDoa63w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1x9q1q3HGG-005ZX9; Tue, 15
 Sep 2026 21:25:10 +0200
Message-ID: <a3c2a1ea-7891-496d-9923-a2607afa1e2d@gmx.de>
Date: Tue, 15 Sep 2026 21:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] thermal: core: Introduce
 thermal_cooling_device_create()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <8729484.T7Z3S40VBb@rafael.j.wysocki>
 <7ef819c3-5155-48fb-828a-48d9bd72e54b@gmx.de>
 <CAJZ5v0icBLqUiU4ZF=iY6TB92syM_c7xGBJ7Ag7DGt+f7THHRA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0icBLqUiU4ZF=iY6TB92syM_c7xGBJ7Ag7DGt+f7THHRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMrPfxTcse46cCbIvTJUwOIait7UkA4stBVGO9ThVblDyA6DJvO
 78vBz6406xmLI0t8ANq7M/yACZQGK4F9mxmkwjktYL4H/vfmmZw74iNQupofugVuqqGqA2l
 193XiI45wsDl7B3x0kLUAOlpWvuQCi7fQPBgo6WKjGMvSsKWIUJLw64emd9iSB5vbrBxDiW
 Sk9cO6WycL6bhBv3cf9AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:laYf/41f5YE=;3Fwlziv54Sj+fFA1lfyYKzG20Ox
 z/3DEq+CUZ6zwQfjJAtA4Ug/MjV4sJUQc1OjAFdMFafqd1XU6esiydfvahgudNKYrWocGHFOp
 sswKeK1klWwwfnjjKRntXB6GAcDIPVBsoroP+3y68WnY1zLewJUwqZlq2Ony2Awj9h1ppUe0J
 cBX7M3moePj/+DShxBrRKhpV1DiOG8KkQaYeFprqeAt9Z3A7+TXqW0anseQUaepU0Sa6iZao5
 fC+UKCTLpPteQlCFC0LYzQUcH16IOZNqk+8gr50oVUXvDAbwBfaV5AWR0v/EDcPeXN/wRxB1I
 b470iWc64P4s1KapIOKqcJY5m6DZIZl7PV1h2Em5EWOmX1myLCMJXw/x2YqXelCCdlBYdCdtF
 0FMHQQnDmA+ZkuW2DD+FDBCeQk70AeZlpJOkzmWW+expvWmrN2lNJoLlZWW3Z2ksO0pbZZYtT
 VOVMd/raLP2m8A9gVqkMxU/MRY6QILyiCdofMOeVg5Yagl7ChaDH4ymNEOY/LisVih0FMN97P
 1YmkUlfC8j84Ib6H6/a65l7nLsrvFDfOinbsP/F8fyw34pNZy4Il8R7MCjPSGLIV+s4ia9Go9
 BXsyRu3k2vtQFfBWgJYpKcI4H4+fY2s5VJ0KfecKIB7C7utNssi4nh7u3xGjC56wFybKvBdXc
 kc73naCvO9dgZXjYA4JMGBIP/g5koRzSV/RIFBr2dcQzfu0gB2BlO0fOtTJg4zUJyknJaw/Y3
 KImyMllIYRDhmpTSryDU/Fds/qskIOzXJ3Qn7zat2m4c/5LClB89fwmv9w88pBcVX3nukWEgV
 21f4YBW18eG/Ps1PFWjCq3GOBNnyquGsU8JbjYDsYAJMA3NTaI5K6fhuhOKEZY1DtnvC6FOZZ
 /US6sR0rSTOmL2akEKdCQqZcaGiNth46ymnh8WT1iwjnuW4bPDM61bQbFe8j4MAyhxeUzQx88
 iifsm2kMJ4qoUxr2L0e7b6zwz/nzA1jAJ0Daq8nwAkxywUJMeGCwkD8Y+YulH1PnM1iM95umV
 uv1XHQi+OGIVWWy5hVUCnuBtefMV+HcQ/XBdsu0ih1ZvjXGjWxIrQjafeBCcEmxkZT85PWrHn
 3h7uDUPTfQmqt4jafmyMFBCd0d0tcQFz7OxLVZHLC+Mfme3L6i//bM21YU0Sf2qVekHZXh2UI
 Ww0fYk++5sReKC6+JqeBBR/lCnVOz8cCmFBo823b05u4Q8bqaXpKwcHOoEKppEB/DJtsHphYv
 hx818kEvJh90ZPz2aBSkW+ExNRX9lv1s/VGn/yYKBK87fNahINqeIu2Z8EBcb8nwbbQvavN2k
 RjpUeQF8mPDM6ekWiEnYwhoYhDisZ3nDHQ0o/JhEQro+ekrlpH5F1PJTmfhbsSiXVBtKO1HrM
 wx4I3QWWi3xxfSbsu8UX+AVS3UiPlwYr9JMIUOvV/NT1gKdcaWMh36xmCrNBS7d2UjDcapsef
 espNON3VWWlAUgr3c1VZ6qj0c/GPyqqvK6pgDffNe/HhVmdxKS0IlFREt5cqG+uOM1uofMPRJ
 7oxAoxDeblbiiTliNhIyEj7OUM5tQ1cKNODA0zKEmAHuk5bF4siq+23UYEYzZyqgt1VYY3PoM
 GzO39n9vevy6ttEb6A7qTyqbavQGtjZepj4tNBxJlpukZsHTyQevN417lmK6PSZvJK6DeJMRy
 sELTxrlwIaaCKSMITPCrnMU8GfY9iPk12dKdTU3e1jmUNIyTqnfNKYdTJIziF94i66he8D8Mg
 XXVin2sZHDHOE2oIVK7zKpIGvOyGLwks1Q1RXm4gW/+bJ/YO41whedHidtdBXxlElscnt8zzJ
 YdAg2ZX2E0/vSZul1g3V0MVBYtsAihM119ero4JlzPGw8BHtrsBXVS+KbUvSeeNHej3zA6wdV
 WOfPbp3tvR4EuQr6qlLMJj9stVFwiIMe5oR8Zh3rYu9HzKb5LzYbt2rU3iSlzp/EvmnRS3UWn
 2W4XBL7PN7xa2ngdnqKRH+wwn0GAE3VxPIGLjOB0xn9rkGgWvYNGmEoYNqWxrCcHCw4uZiKwn
 +/sz7nERHFhpAaUPmvNztr2YevBpj0eK5Bd5ksfz/p1qnFv+x+3c4tWjsqjhLKiCQvUisTosg
 SAX11fFAOKuYNr1OTTeqwuSrEqzfuGNk1Rk83e3jxTHPfsqomr66gI9OhF10G7KFiH8dEfw3F
 xKngIrMHZL6suodKeyJERIqi5RhaOeZwmnyD5/Xt9eiqujpIiptchUv9rgdGSUMDgdyY1K1UC
 KTQ+i4A6J7GpmmhaWYA0EwYm2T8hpHTfjKhMDTmIBih2my230Ld4dv2kf3pAC3p5iJuDizpMD
 hukxXfwxUnSU9dkgHm6hQvhI+sOB7c/mAa+6ekDGtmLiPf0Rg75n21g4dQwar+rYRz4bMAAFH
 wivbBdo1YzGFTasnjUEbervykV9H4NddyBxgql5xciwPtoJQ8rNtl1cWUakPE+qhMaI/MtMCh
 K+UOsYVuH2udIbF8yrXmYd6yeqrTNcRRbnvO9AOSoE1IQUbbuRx3ZyDbT7brbcYMmSHXqNjHl
 e4nwfr/je38ViJs0fhy8c1MutEzxyeCCKS+BUsPhI693Cg6wdMbl5CHojYizlJDf7jUvKmirE
 uE5qNlj3IHPet2CU64alX/Xd4QU7a2wBSE4U1ac4bDNpqRMphvkRXVkEl7wPkrbk1CuNOIla2
 cvkptDoZSy/B0hhY6PzojfuV5Spgys+kfvZdtL+oEdnFl35HoJfeX9cNqNQy27QzJ6zffOl3A
 9lx6JSquckkYA9jO4kb2cTXjAx8miYuXQ8liZR0Uz32kfs0Yl7a/elH/cAKwUCCwy2ow0OPqt
 KVxEjOUCbvHUR/higSavw2JlITxEA0Krovw301U4WbP+Azk1uC6+xiginfsrf9JZ9PGILvz0V
 rlqlw8+cgtPqCMBCVGivgRYk5qS9HTYSRHEUpl+SbpAPbAL2PmKELg23soC0Dh3UM0ecFaiPC
 GxxqWSJL/CB7woGkeZGObAUa6aRKWkU5ULUa0XRW7STOtZlsj3Xrl5EMX1/hUCoxfE9ma39wm
 q08T4eECsNyuF3c8FYxkvxH+woISL0L8Rhlu4nOOVLblyv8w+nYRql4CCyaBaGx+mNVC11ouc
 YqlDVyokQjEMMBSCBmnqNndy8UpWg54fMDbwqRXJ0PcTbjDS612iOMiwbFPaqJnvhAg9vaZro
 lIvn1XOS0HOQj4BBoX5tORkdVhBB53pxtYdPp9rbSKs85D8FKsBhnUyCTbYdbUW4+/GFNgK7W
 Wz36b4r3+Hcl3HkxavxhTWnLm6nB7nwbbo7MST2UPsEFNFSzGdIPxhSBu20gjH2pgwLFKrk5Q
 nTmOsEXVH/hb7xG9bgC2P/xZMbulivkvIWELZsoydrGlW0ISr2/LePEJhALkUkZO6q18BFO67
 InXC5qOWvBGjCndN3fizXoN93EIFv3qLLL9jb4H9jsDGwuIpOArBnJV2LbrCw6g9J+v9aXAvr
 Cl7XPNwcuQrpuZPb+KIgxdx0p9AB5HKLx5ZmsCSWZ9ARPedJpdJn8IQtvL+x++ELcyjp7VEj/
 8yl6YBNjQM1wDbCJOG4aPIvHUYqRuchyaou5pTq7vnqfF/gJDuC4Ryk3G++n5F8uEhqiDH8Un
 t+v0cPp1ns/1zvlDhRq4OTfTGC98ILQzB+v5hakiQ1xTBezsRwXRawPlrSvWIBCxVpjWGBrwt
 c2m1ZumBIgUJdzHGxi4VmgLTEd99ltnXQclh0iu1w/KrCV0j3fR3bL/GRjnA7jF/FUH8WNIJl
 6xx+nqr7/moCOIJ7yaIe6pZPzwk45DhViwaqJoLrE/dGre9mC5CAjdKV3oP1SkpcvnNYK3eyf
 VKzLJs0tqXrDVp5pRli5f6P1nI8Tyd/i3haLHlKwCB/I+ij7ToIdZOsPRxHatwHHapC9XGM4v
 xbmFiR3fdOeBhr6aKriovEQy9J4ZNrMQ3zSNCOYfvQjmcSXnd/w90y/8d0oABYS7M5WkTTUmg
 gkq45sidObX82e7gmyjU7MxN15PAfF+KB23ZrcmRhF3gkhJtdmkCKhpgR6hQBuKx0VrhExlzo
 sGXf6GB3imskoiA257uG4Sder1JVxq2ZPHzptRcPktPgAs/kWV3A+AZtLZ4ssHNBFl1xKMZ9Z
 PfabVoJs+uGti6+FNNG7t82Ev49A9n4Ix2wxkpKa7bu9BC7ay7C6T9yaQoIoimj6aDTEro3jw
 9vFi8zyOjTNq4SNlCGvFXB3pbDlmxzguiJcKibC+jlgP+N+cAlJDkwx+uUztSQkyt9RacHvON
 QrMhq+SgADTFosYrvNL7XdCmxgn5bJyNBekgz93gx/LEsNO5og6/WxgaEoUfyN9jEXkk3Kxzm
 Mqae2+E25qCYCYIjPgrMqOSKC9QTI1lvKhR3/YzuN7YIhdXxZZj2cMBtSZclqzxV38IQqJWNm
 jny1cYW+mcCcbgLpi4TH6h5M0k+JX1h3zV7XWKALnU+GGm1ELO54N1faQ0HG9N1U3qQWqraVq
 VbLtoWHtOS6XtxWl97oHyS1AmubrRFOtLegOD+ZOgq53TmUvkGQozg/Vlb92AozFAmFZpUWW/
 HyPq9Hp2wnE9U4YK5Tuwoi59aGj6L6hAdYH3/wCzJ2tLXgFAcy6o2RME+4k4Hkj2HWF1j34r2
 EARp0jMdNUZyAdDpOKjWQ+ilmgcCSCDd8Ut/Gadbcs/jd2/9+COGoe3CDZDj++9ANs85WLsEX
 AlCahtgr22xoRJaVg/wr+Wz+Liob2q0AnwrAC6MbMF7dKvZ/4S+K+r++RPuIQNtUlGvu2JNmK
 bvVQg9DGuTlywB2TbANq49Jlg/V6o8Q4/YPyVQIoovPKqFZ48VWTS8bAGvg0bpwSfOj9dD9cP
 h8nfGc56LlyUjypyMRiWqVa13mPt7pWD3NM16sxf3Qjk0a9vsjCns68aIDjucuwif/qyY45tj
 3eZOnrGiQvO4wuxxhq1Q7W+UDQ2Vfp0GdJfMScYkJWgCci1Rfy9vOGGZnsWOchCmaYLBG30DW
 GiO6YX6zJALaWN/xdKGVG3PTM3CyQ9pq4hmqEjDTQRCx2+t4O0HNH7w6ZNNmSyWEIm0pPzTTG
 8b4Rh9778GuH5YxNrvVkRlBUKDZkA0XB08vq0b3zlQNozNFar4hUeXnTz+ORm05lceB/NEwc/
 00OjoajU3oC+2Kwk8gH/DjvQNXgueaW/bIT8qivjuoclt9uQ43Y4Q8mZp+SaTVNIkdCsbzyyY
 jkA24MAj8gAywryAgqwBrMISjSCZStAO1iFAJzHQoYGoeJyO/YyYi+/MAbBszNrGlY0q8xmJY
 aqAyHasPV0kaPExFZF4FSet/gGfedOTsaZcAikf9VVQpeEBzXm3z/OhSAt0U6+4FBtYuiYabG
 wBxNSHJtnqAJBaXu2Yucy19QCFnihXhmKv5ShVvN0bWle9uR49rBeSFVmymwuM5zO6mSVfxKo
 VtBxx491XY0GbSRj4hQyw5IXt9gv1tPnfcTQW4/Mm5zfva0hWl+uftCcGX2zHonEA6n0r/xuH
 sli9ipMDlJL3wur3Y/ZWtAhsL3JGqtO0NZ84ZTEtQ0s6v2dQzlyCGCNIW2AnDxd8jjOPdINm4
 8x1VpZqNzUJXXOubPoqnWKL6xOSFW9oJgBrCSEQ63G661f+gAxGJwH70s33FpnyYMygVqf/Uu
 QUpNzfoz1lPRTo1Wbj1j8cRBBHji1iHYPPci9ISkGr/ceI3OhyPskraqRklv9jf7gPVVIju5q
 RLSwmkJ51nkZXBFxDeQQyCY/AKk091LFxabQqNOi4BkVL3zm+7ufXqOo/pAWOGOSp51XLy3rV
 XAf2Qa1gApt+hnZK3UcP/rFozvz2QFsVmNM1jrnWj/+eDnKxIZiFPZpiRSKirGWWu3Zn/XtaX
 nsbuls/GN27ifiePySZmu1z5R8QbMhjf2VJJ+Gys0UhFb1wqjUT5rBwLdbuvpxuWyeM31ghO3
 mvjEuSag758lqcxv04uDiC2bXiSKxYrN4q3HwmfnQfttQ5FNSof7zdwP5DgsEMx2v8xK3eHPo
 kKyMdYMrDpaABvzSD+tOJTUBllHXCCfuhzwA78SY1grYzSWt7WHrkmDKwmXoSlwaHOJmqENot
 E13jkdi6RVhnrapD3rvgDhNjQHXF++oQj2UAHFVLlJG80bE0DPIyE1PKIhyVSRFAOMELHLkwD
 BDXkh7m/tBki2NP3FBFTp4itNV9bPMA9OLkrUGDQTQTpKPCWXJSu+P3jaVPWxpBNnFa2nRpil
 Aw67Zhav6aOyKHZ+rI/qFU7X7qsZ98kOOfXxH+c48gSZAifPfAlgo4U0ClpzjIejcivaOlVTJ
 7T8FNmkhnnmto9rePG8gZwVydLhv3TGvztU5VH2DpJV2twxqfFnvVv6PoZy9k5BAE3moGpCYD
 UNZYBJJhDkZDx

Am 14.09.26 um 12:18 schrieb Rafael J. Wysocki (Intel):

> On Fri, Sep 11, 2026 at 11:04=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>> Am 11.09.26 um 15:02 schrieb Rafael J. Wysocki:
>>
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> Currently, thermal cooling devices have no parents, but it would be
>>> generally useful to be able to create them under specific parents in
>>> the device hierarchy (for instance, it may help to identify the device
>>> representing the actual cooling hardware).
>>>
>>> To make that possible, add thermal_cooling_device_create() that will
>>> work like thermal_cooling_device_register() except that it will take
>>> an additional parent argument (which may be NULL).
>>>
>>> Redefine thermal_cooling_device_register() as a static inline wrapper
>>> around thermal_cooling_device_create().
>> Hi,
>>
>> i like your idea with the new registration function, this gives us more=
 time
>> for migrating the other drivers. Should we mark the original function a=
s
>> deprecated?
> Well, it's not a big deal if somebody uses it in new code IMV.

Ok.

>> For the patch itself:
>>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Thank you (and thanks for all the reviews)!
>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/thermal/thermal_core.c | 28 ++++++++++++++++------------
>>>    drivers/thermal/thermal_core.h |  3 ++-
>>>    drivers/thermal/thermal_of.c   |  2 +-
>>>    include/linux/thermal.h        | 19 ++++++++++++++-----
>>>    4 files changed, 33 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
>>> index 82e2f0d8a26d..ac928c199829 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -1005,7 +1005,8 @@ thermal_cooling_device_alloc(const char *type, c=
onst struct thermal_cooling_devi
>>>        return ERR_PTR(ret);
>>>    }
>>>
>>> -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, v=
oid *devdata)
>>> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
>>> +                            struct device *parent, void *devdata)
>>>    {
>>>        unsigned long current_state;
>>>        int ret;
>>> @@ -1013,6 +1014,7 @@ int thermal_cooling_device_add(struct thermal_co=
oling_device *cdev, void *devdat
>>>        mutex_init(&cdev->lock);
>>>        INIT_LIST_HEAD(&cdev->thermal_instances);
>>>        cdev->updated =3D false;
>>> +     cdev->device.parent =3D parent;
>>>        cdev->device.class =3D &thermal_class;
>>>        cdev->device.release =3D thermal_cdev_release;
>>>        device_initialize(&cdev->device);
>>> @@ -1062,21 +1064,23 @@ int thermal_cooling_device_add(struct thermal_=
cooling_device *cdev, void *devdat
>>>    }
>>>
>>>    /**
>>> - * thermal_cooling_device_register() - register a new thermal cooling=
 device
>>> + * thermal_cooling_device_create() - register a new thermal cooling d=
evice
>>> + * @parent:  parent device (optional).
>>>     * @type:   the thermal cooling device type.
>>>     * @devdata:        device private data.
>>>     * @ops:    standard thermal cooling devices callbacks.
>>>     *
>>> - * This interface function adds a new thermal cooling device (fan/pro=
cessor/...)
>>> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to =
bind itself
>>> - * to all the thermal zone devices registered at the same time.
>>> + * Allocate and register a new thermal cooling device under the given=
 parent (if
>>> + * not NULL) and with the given type, device data, and operations.  D=
uring the
>>> + * registration, it will be matched against all of the registered the=
rmal zones
>>> + * and it will be bound to the matching ones.
>>>     *
>>> - * Return: a pointer to the created struct thermal_cooling_device or =
an
>>> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
>>> + * Return: A pointer to the created struct thermal_cooling_device or =
an ERR_PTR.
>>> + * Callers must use IS_ERR*() helpers to check the return value.
>>>     */
>>> -struct thermal_cooling_device *
>>> -thermal_cooling_device_register(const char *type, void *devdata,
>>> -                             const struct thermal_cooling_device_ops =
*ops)
>>> +struct thermal_cooling_device *thermal_cooling_device_create(
>>> +                     struct device *parent, const char *type, void *d=
evdata,
>>> +                     const struct thermal_cooling_device_ops *ops)
>>>    {
>>>        struct thermal_cooling_device *cdev;
>>>        int ret;
>>> @@ -1085,13 +1089,13 @@ thermal_cooling_device_register(const char *ty=
pe, void *devdata,
>>>        if (IS_ERR(cdev))
>>>                return cdev;
>>>
>>> -     ret =3D thermal_cooling_device_add(cdev, devdata);
>>> +     ret =3D thermal_cooling_device_add(cdev, parent, devdata);
>>>        if (ret)
>>>                return ERR_PTR(ret);
>>>
>>>        return cdev;
>>>    }
>>> -EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>>> +EXPORT_SYMBOL_GPL(thermal_cooling_device_create);
>>>
>>>    static void thermal_cooling_device_release(void *data)
>>>    {
>>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_=
core.h
>>> index e98b0aa5aacc..7ef7c6cab437 100644
>>> --- a/drivers/thermal/thermal_core.h
>>> +++ b/drivers/thermal/thermal_core.h
>>> @@ -270,7 +270,8 @@ void thermal_governor_update_tz(struct thermal_zon=
e_device *tz,
>>>    struct thermal_cooling_device *
>>>    thermal_cooling_device_alloc(const char *type, const struct thermal=
_cooling_device_ops *ops);
>>>
>>> -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, v=
oid *devdata);
>>> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
>>> +                            struct device *parent, void *devdata);
>>>
>>>    /* Helpers */
>>>    #define for_each_trip_desc(__tz, __td)      \
>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of=
.c
>>> index 0217a49b08ae..14dfac9359b8 100644
>>> --- a/drivers/thermal/thermal_of.c
>>> +++ b/drivers/thermal/thermal_of.c
>>> @@ -561,7 +561,7 @@ thermal_of_cooling_device_register(struct device_n=
ode *np, u32 cdev_id,
>>>        cdev->np =3D np;
>>>        cdev->cdev_id =3D cdev_id;
>>>
>>> -     ret =3D thermal_cooling_device_add(cdev, devdata);
>>> +     ret =3D thermal_cooling_device_add(cdev, NULL, devdata);
>>>        if (ret)
>>>                return ERR_PTR(ret);
>>>
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index 083b4f533933..306ad17aed89 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -293,8 +293,9 @@ struct device *thermal_zone_device(struct thermal_=
zone_device *tzd);
>>>    void thermal_zone_device_update(struct thermal_zone_device *,
>>>                                enum thermal_notify_event);
>>>
>>> -struct thermal_cooling_device *thermal_cooling_device_register(const =
char *,
>>> -             void *, const struct thermal_cooling_device_ops *);
>>> +struct thermal_cooling_device *thermal_cooling_device_create(
>>> +                     struct device *parent, const char *type, void *d=
evdata,
>>> +                     const struct thermal_cooling_device_ops *ops);
>>>
>>>    struct thermal_cooling_device *
>>>    devm_thermal_cooling_device_register(struct device *dev, const char=
 *type, void *devdata,
>>> @@ -340,9 +341,9 @@ static inline void thermal_zone_device_update(stru=
ct thermal_zone_device *tz,
>>>                                              enum thermal_notify_event=
 event)
>>>    { }
>>>
>>> -static inline struct thermal_cooling_device *
>>> -thermal_cooling_device_register(const char *type, void *devdata,
>>> -     const struct thermal_cooling_device_ops *ops)
>>> +static inline struct thermal_cooling_device *thermal_cooling_device_c=
reate(
>>> +                     struct device *parent, const char *type, void *d=
evdata,
>>> +                     const struct thermal_cooling_device_ops *ops)
>>>    { return ERR_PTR(-ENODEV); }
>>>
>>>    static inline struct thermal_cooling_device *
>>> @@ -391,4 +392,12 @@ static inline void thermal_pm_prepare(void) {}
>>>    static inline void thermal_pm_complete(void) {}
>>>    #endif /* CONFIG_THERMAL */
>>>
>>> +static inline struct thermal_cooling_device *thermal_cooling_device_r=
egister(
>>> +                             const char *type, void *devdata,
>>> +                             const struct thermal_cooling_device_ops =
*ops)
>>> +{
>>> +     return thermal_cooling_device_create(NULL, type, devdata, ops);
>>> +}
>>> +
>>> +
>>>    #endif /* __THERMAL_H__ */
