Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198496;
	b=M5aMmQLpPQn/zra2K2dhntIXKMi0LJ9uzNMNGujndmUOg6EtNiCUVtnbnvjCdk2UObzN
	 86mAvBsN5DzJ8ztPLCgel18vJ3qIW/yeD9IRwDwSxykkE2pOUDGX4yGqjJM8dOsDGE6iq
	 6S3dSvDE/1rNXSbk8njSgLApjfDyeW4X0xIKVSXkummbgIGfZOi10LKyCXQ7CuM2KxoW+
	 rKbvdEEZs7rAj2Yz0D73ovbLoOMyRMAbz0eIWRk+Uekb+bxyETEFEl+QZ88CbGaqAKbAR
	 v3zhj5V4FT9Vcxax6QLUjZRtsaCpusQKHaZFEEP8DrBw/MF1L3ZCeG2h1EkYncl54Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198496;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cU+ZB9844KPXAcjrEqi/T/TxmCtfMJe4KVaRRxeF4PI=;
	b=LFpHfIxpKbiwaIgI+WVAM0m+ixObdKm1aF6cH1C4bQgHDNIDJoBRb4fTgqRT7lpT2Esq
	 iUcpBUFy+Vy1Kxh/cLJY6IBJ76cGGZd4NnCmoqdFUY1gjD8MQaZSv6A++3774+VZYe42q
	 jxtPInjTaHXkPN4p+rR/RsXNhzS3fY5efxyP6Xv9WUV0YrmtIFKyGHZuhPjwdyl7Q6aKy
	 J4RHBdok9XY2w/GCXMyoTSIhMYqoJLP+xd7shJGzA/9T7VSKzW9nizS9A9j7+pYCwZUUV
	 7Kq+C7Fna/o1cA4W5Oxt9ekDG1Yqa9sPu4K2iwXOQITAbehkLJgk6BnxhrLRJ1Ug3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QK6P9sRl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dE2iqtn4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2044606A330
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 14:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2044606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QK6P9sRl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dE2iqtn4
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBe2Mg1538955
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 14:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cU+ZB9844KPXAcjrEqi/T/TxmCtfMJe4KVaRRxeF4PI=; b=QK6P9sRlLQRXw6DN
	5y8otHdGrG0lxl0Y26kfdeAF0hp4rr10saNLUaBdlF4GUhI3ELvHc4HAnnpF6hnz
	msyjQAT5ZSqRqyADyOQolglwcbUU0614GTZDpLbZAaWs849h+4+EvfUV+2usdeDm
	m93j32xYU8ZpK2tOOaZDCgGbkkfXUiiaCLDqdRR5tkAFfyxC9buM5dU0SzVtNU8B
	IVxhnfWAvRDfqer7AgM+0Sl1RqTbGYKnZmCNJMj8K/fdj1TTE04G8g/MxH7eUZ9F
	nJwr+XtE1K7FI3kX/LVcI2OAvZmaABsu8lCpO4TI5M7xxUBO7SQjZBlJiBMfJwJr
	MaKsXw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7seaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 14:41:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso1230966a91.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793198493; x=1793803293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU+ZB9844KPXAcjrEqi/T/TxmCtfMJe4KVaRRxeF4PI=;
        b=dE2iqtn4jyxZogmzG6xMCFssuZNzBJCTBOFSvjRZkIFS0mOC3kVBKzrljCoC+SQpR2
         eDwRi70oNzQS7iYq9Upyh1ohmaiQ5E4853fcqgvrNRlOOInk9DLPcdXGx8werPWgIg1/
         Ej6SoTdNezQeZ3QsYoy06BJuQU/zYO3ag5iQcdXtiTCuwPPfA3oz5BFQVw87AtwEq26K
         0zzI+Hr9IpOOZ40/bntcI/t0tvn46d0OgTwNwlt8FLSMS0af4Y2FpMsLFZH8NdQ53ZXt
         ZUgcXj37/jiS8eLyvylpRaTOcWVAEPbjA0ALgirgLHtJvZSX8cA1y+zP3+5KKixHYtOd
         kDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198493; x=1793803293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cU+ZB9844KPXAcjrEqi/T/TxmCtfMJe4KVaRRxeF4PI=;
        b=lcdd+tS65cXIvRfgnx3M2YXtUYsXNpNCxk5VHdfHEEVFXGp+N0CXu17oXuB3xAcuM+
         Ld1lGbMYsHZKNTiPLonjaMWEqU1Hu0LQLklQ12rbsznH+oWAF3zYU1lyc/3ZBpSwWjtx
         ZRq4OqzoLrQlgl6jH2im3wJSX13FPdfU1FuGKsRk1AJAT8yW8UEq77Xi5GCaqRw2QFxd
         OA+aN0DVt549sxwzQ4fTTbI2E0zwu73wAJ40RczOhw5quMVCfqAhmjI54srUKUq74dLp
         KIf/DBUn53RLEKtm5DTRUg4p44CKPOnigfWjRZPvRzywz/NtLzEATOgogZgB/qKxdnA9
         7x8Q==
X-Gm-Message-State: AFq9FYIqCTpxA5z564uukxfGKHJd2H33g/aeXm4SnpdmlgPCWO7kybJ9
	eWJsiG43N4yEaORLPQpXp/cEQAf5TtNufO5PuoujGONJGyaRzV0ggETb2iZLuxf0yXioapuKuj6
	qlSoQfnSbCjpoC268gx1qXVG/eIlQP6XAW9XWD9cUTO8+KAz7YYjl1SEijoxiEw==
X-Gm-Gg: AYBFou0P/p51JTNsW0ST6ahG5To8to9LX3dmzmrIF+SGEGgHjwWJHtWFGK/gy/7dDGP
	yebjfStmTwavUb42+Fz0k2T/eJZvlyj/P6pbUELcAtXyO9Grga6+9nUeVjmJAXs9icDUVrxFjtx
	+DnPfI2ZZ8gNxu2axPUCZddXPO5bqTfRAl2GqQFVBTjPxyCI3N75uUrJFZ2vMlPjrct+iSyOiE4
	XWru+OtayO5qRtEizvy9SnK2ltMZVUnPhDjZRUheSuG9U+7cKt4aRdvHru8wLVKGnmlkTss7b6Z
	NT9bX/Ez11yCy3S7cgAV3tQUScackEMWT4OnJycfw9MPEJtUa5heWZ4yvyk8eHJI9KVKKAJg5TI
	h8O+kAKufGBAENlakvLR2ivzBpSHqCDb8/wKBom0aApdnPcLwnyDjSwWshNLFqmOPuFqHZoazz2
	gjTOaQwKOho4W6/Vbd1Nl2Vcpczyzfgzm2RzrLyMhFbr0x
X-Received: by 2002:a17:90b:2296:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3ae57e2b787mr1494813a91.9.1793198493233;
        Wed, 28 Oct 2026 07:41:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2296:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3ae57e2b787mr1494800a91.9.1793198492549;
        Wed, 28 Oct 2026 07:41:32 -0700 (PDT)
Received: from [10.133.33.238] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a5839besm3357980a91.11.2026.10.28.07.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:41:32 -0700 (PDT)
Message-ID: <b228d3c3-ac4b-43df-8829-edb9c459860d@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 22:41:28 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: cpufreq: stop CPU hotplug loop after
 cpufreq update test
To: xiong yining <xiongyining1480@phytium.com.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenbaozi@phytium.com.cn,
        zhongqiu.han@oss.qualcomm.com
References: <20261028100241.189085-1-xiongyining1480@phytium.com.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261028100241.189085-1-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae2099e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Vt2AcnKqAAAA:8 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=fgrLqfBXAAAA:8
 a=rLnwe5TcSjkNIz7vCUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=v10HlyRyNeVhbzM4Lqgd:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-GUID: ONQdbl9MTR2zFY6rzS8ngxxul2S8SPx7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfXwjCDgEGfmdcE
 JXExjMvZNtEpaqK+2BfVXKdY2Ns2O6ch8Opay4R+Ib6BKxfUjFapo1TRRjA+HuZbEaiEnTY05VC
 D7YG0KBCyjbkpl9Up3JoTDsuUrXTsNQ=
X-Proofpoint-ORIG-GUID: ONQdbl9MTR2zFY6rzS8ngxxul2S8SPx7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX0TqKI21XOC82
 imUnW4qaVDNYN7UJws9D4CzjlSvaJre3mqgjvq1tbsJZyNbz8wjyOvyXcI9Xzxd+TyQWsvKdZnW
 jFU/N9G1o5W1tgcEyAHMB0Ismf6zib9dyLujQbiN8znTmQHKlbnxjYGd/98SxUsE6SIXBwIW4/B
 bD4N4OLG9A0+tl4aqEEdJuxlFM4btLrjgucWaksdr4M4KAJBiZFBAhFCVSETLadPejGkAuYkGE1
 dv5wNkBMKrTAjMz5YPje4lAQp1bslBTo8FZwJ5a0tqHF32brceUZeCG2Y4r/6LHqv/J2QVE7Tsq
 r2lUSrOEaq3HnAw38U61PXL/kfvMjeeHw+MGX2lV3PDOc9TyzRS9vvoZ+aFFdvjVgXyEjyOTuOk
 qYBJx1h5odHJ+Y8oY+e0gXxGwZQjp5lfcMntMdOXoFA60KLnmUN6ChvXA1ryP+Sm5rHbRkBeZfE
 u0YHPfAXDRGlhzEuEEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280058

Hi,

On 10/28/2026 6:02 PM, xiong yining wrote:
> Original test uses a fixed 5000 iteration loop to trigger CPU hotplug
> for verifying cpufreq synchronization between CPU hotplug and sysfs
> writes.
> 
> Two issues exist:
> 1. Background hotplug task keeps running after test completes, causing
> redundant CPU on/offline operations.
> 2. When cpufreq frequency setup is slow, the hotplug loop may exit
> before frequency updates finish, which breaks test purpose.
> 
> Introduce a file-based stop flag to control the infinite hotplug loop.
> After all cpufreq updates complete, create the stop flag file and
> wait for the hotplug task to exit.

The changelog still describes the v1 stop-file approach; please
update it.

> 
> This makes hotplug run only during cpufreq sysfs write test,
> align with test objective.
> 
> Signed-off-by: xiong yining <xiongyining1480@phytium.com.cn>
> ---
> Changes in v2:
> - Stop the hotplug child process by signal notification instead of
> a stop file, avoiding the predictable temporary path.
> - Add an exit trap so the hotplug child is also cleaned up when the
> main shell terminates abnormally.
> - Link to v1:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2662696.html
> 
> This addresses the security and robustness concerns raised by Sashiko.
> ---
>   .../selftests/cpufreq/special-tests.sh        | 30 +++++++++++++++----
>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
> index e87ed7c8e5e5..b3ebead1c52a 100755
> --- a/tools/testing/selftests/cpufreq/special-tests.sh
> +++ b/tools/testing/selftests/cpufreq/special-tests.sh
> @@ -16,6 +16,8 @@ source cpu.sh
>   source cpufreq.sh
>   source governor.sh
>   
> +HOTPLUG_PID=""
> +
>   # Test 1
>   # $1: policy
>   __simple_lockdep()
> @@ -92,20 +94,34 @@ governor_race()
>   	restore_all_governors
>   }
>   
> +hotplug_cleanup()
> +{
> +	if [[ -n "$HOTPLUG_PID" ]]; then
> +		kill -s SIGTERM "$HOTPLUG_PID"
> +		wait "$HOTPLUG_PID"
> +
> +		HOTPLUG_PID=""
> +	fi
> +}
> +
>   # Test 4
>   # $1: cpu
>   hotplug_with_updates_cpu()
>   {
>   	local filepath="$CPUROOT/$1/cpufreq"
>   
> +	(
> +		local quit=0
> +		trap 'quit=1' SIGTERM
> +		while [ "$quit" -eq 0 ]; do
> +			reboot_cpu "$1"
> +		done
> +	) &
> +	HOTPLUG_PID=$!
> +
>   	# switch to ondemand
>   	__switch_governor_for_cpu $1 "ondemand"
>   
> -	for i in `seq 1 5000`
> -	do
> -		reboot_cpu $1
> -	done &
> -
>   	local freqs=$(cat $filepath/scaling_available_frequencies)
>   	local oldfreq=$(cat $filepath/scaling_min_freq)


The background hotplug loop is now started before switching to ondemand
and before reading scaling_available_frequencies / scaling_min_freq. If
the CPU happens to be offline at that point (such as single-CPU policy),
those accesses return -EBUSY: the governor switch is lost, freqs is
empty so the update loop does nothing while the test still passes, and
oldfreq is empty so scaling_min_freq is not restored. Please start the
hotplug subshell only after that setup is done.

>   
> @@ -117,14 +133,16 @@ hotplug_with_updates_cpu()
>   		done
>   	done
>   
> +	hotplug_cleanup
> +
>   	# restore old freq
>   	echo $oldfreq > $filepath/scaling_min_freq
>   }
>   
>   hotplug_with_updates()
>   {
> +	trap 'hotplug_cleanup' EXIT


AFAIK, regarding the EXIT-trap-on-signal remark from Sashiko:

https://sashiko.dev/#/patchset/20261028100241.189085-1-xiongyining1480%40phytium.com.cn

Bash runs the EXIT trap on SIGINT, SIGTERM, and SIGHUP, so I don't think
additional traps are necessary. This issue occurs with Dash, but not
with Bash.

One sample simulation script：


#!/bin/bash

for sh in bash dash; do
	command -v $sh >/dev/null || continue
	for s in INT TERM HUP; do
		out=$(env --default-signal=INT $sh -c \
			'echo "$(readlink /proc/$$/exe)"
			 trap "echo EXIT-trap-ran" EXIT
			 kill -'$s' $$
			 sleep 1
			 echo not-killed' 2>/dev/null)
		rc=$?
		self=$(echo "$out" | sed -n 1p)
		res=$(echo "$out" | sed -n 2p)
		printf "%-14s %-4s rc=%-3s %s\n" "$self" $s $rc "${res:-<EXIT trap NOT 
run>}"
	done
done


output:
/usr/bin/bash  INT  rc=130 EXIT-trap-ran
/usr/bin/bash  TERM rc=143 EXIT-trap-ran
/usr/bin/bash  HUP  rc=129 EXIT-trap-ran
/usr/bin/dash  INT  rc=130 <EXIT trap NOT run>
/usr/bin/dash  TERM rc=143 <EXIT trap NOT run>
/usr/bin/dash  HUP  rc=129 <EXIT trap NOT run>


>   	save_all_governors
>   	for_each_non_boot_cpu hotplug_with_updates_cpu
> -	wait
>   	restore_all_governors
>   }


-- 
Thx and BRs,
Zhongqiu Han
