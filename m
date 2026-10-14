Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD534B126F
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978757; cv=none; b=jygBShCpY0+vS3kLDswms+UGu7WXYkt2ggstdGD6DtIjqIjzxQrLQrtkCG/mu1AOpFfDu+V4svatmSzvdmLQL9szhO1NRyhUDvmkLvNsb7hJOA+51ZlcAqH2knKL7pdMcInp0GmzPK77x+fZc1HElsZRI4gp4bqxMvTpAwOQFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978757; c=relaxed/simple;
	bh=YHkNh+k1uYUdhN/GX2GoXGxLYEYQZpiM737GZ/FheL8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=O2slDvXCW1SIlrKvPMai662xgtO56NsXQVJttfQHGoHJ+m7Nya87rhCHwLPPT1Dy4gDDUg1UFtTB/Dig7oQDXw3iqYkaakQ7fJJn+dmCMr+9Z73tLXo7pyAxjt5R9fM8xO9kCXgSNU3mfgFsNs+OSL+rsktYbtE38vQ/ld78llI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20251104.gappssmtp.com header.i=@dabbelt-com.20251104.gappssmtp.com header.b=DQpj1y+p; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20251104.gappssmtp.com header.i=@dabbelt-com.20251104.gappssmtp.com header.b="DQpj1y+p"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so2605337eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1791978751; x=1792583551; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yAV+C6S/vBnhLrjCXwEiKS2AZjZdz8SQL6UJRh8bA3A=;
        b=DQpj1y+p/3qiq+sSYYq3iG1cWsbOzkkIFXpXJ69W3Gh50mQXMi/VCWgRjrKenRKNYz
         kiJz6VW6YH5NboubWsWsM1aNKAHEdY1R1sTiNox+jJLHk2Dr4pKYtq5x42jKpV/aREwk
         8wA+1qOMBV9GIjW5gHOq4pniYD5yjCYH6YdDay651Hswkh1CBYEztWVEmqTu62b2wGli
         taZSO0Z957GRIS/wSnU4Oqt2eyAIYdBmE0B/pxvfXpbagr25QlRPMy0X/mgJ4qegN2wb
         rUJEowdYUeIHxy6BhhLI6e6F7u4j293jJtNJEfOWk+kqnnFpU9PxlTQiDvPOXyXj1Olw
         OoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978751; x=1792583551;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yAV+C6S/vBnhLrjCXwEiKS2AZjZdz8SQL6UJRh8bA3A=;
        b=crzcjldvOCs9MOUO6XcX1G6hVlFsmVXL4uN94wvigHCT2o3xVL3HXXeVyjIvMRnYJ/
         6nzoCeuHxIpuV6MdDvhYpde9BWmRvMHfrAoc0xFaINeKHN4WLEiWBiLVuvuH+F2Mx4Hq
         J3a0XmRRoPYYeYrFwapqIB+FVMwIZoPpVOY9/rkuNqedRxfaG1Jsvd5N2YPS34g7+S4C
         aUzqMhn1nUkBX4xay2CaMCMoSeXsyvg2d4sGrTIv6fy9qoK0eahmSOjfHMd6mAxaOuq6
         8SaluMQv/zCYZZSE/YnNQ2xh9O+z9HgNPCfU0F6kJx4NULA2a7oNT4iL6K78Di0b9UrN
         2aiA==
X-Forwarded-Encrypted: i=1; AKwUvBwAW3GkFXiiZ2vcTA6E8H120aE6rxz/4AYH+Mhiul0DZSDJbHsOB8wKCxe7VPTvjwWiHLx6ajgvMQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLBCjCAgtRugS97lbWhPiM5Dhx0jHTxIw2IOD41ycyhz98p8hAv
	b3SWuas8cu5tzxPBFgv/ao08TTlbtPLTIMl8VAbtYpnnAObK7GMAoXKr1rHUjmX07J8=
X-Gm-Gg: AYBFou1uuSMeC6OCOKhhxTdJMU1aNuft/ObSa/ekjCfW4H+v/P+rXievS0bbSKqbhT+
	7wzw+Q5pi44tK/PhYpZYMLx7tsRtLPq8XUjQPL0zWbnl80DEDESnCFNEYjabzPliR6W8vuWUSQn
	HG83esSm3zJHSdIio9aAj7mxRSNBX9/ZJUKOETkWrY2T6GS+ouQJnwylxxeZgZJ1Zey8KHCdSom
	gnJLtsXkmqZYIssC5CUHho/TZOcK/JDbdin1EvQ/UJAfz3XF93VApcms7IxSd8/SUFj9j8x5Qhx
	6An2gbsFvbBnyxhEh22Z3boI2pfO9Fk9XsvXVF/IhNqxkXVOsDvWkmoOe7owxZ3DVnRdN1phFIb
	QGYQpIql1GR/LjSRszlD1n24ZyturwdfdyuHPTgTtSft8V6gYYncuftl67VakYxBAMQckG2qPoQ
	M8TM+zm/IYa0NUWsAu6GOW4oSv9VsK7lfspfeehOYGyjDSqXh/1sIK/N5rSLYHJjeHAdMxN8Zxt
	rPKTwyIlgQxzxJUnCTmiVulak1vk+aGRbvFm+1H
X-Received: by 2002:a05:693c:810e:b0:359:861:7cbd with SMTP id 5a478bee46e88-35908617e44mr16791919eec.10.1791978750686;
        Wed, 14 Oct 2026 04:52:30 -0700 (PDT)
Received: from localhost ([2001:5a8:4687:d600:c5e7:8e91:8246:979c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35c89429484sm15935072eec.23.2026.10.14.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:52:29 -0700 (PDT)
Date: Wed, 14 Oct 2026 04:52:29 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Oct 2026 04:52:25 PDT (-0700)
Subject:     Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
In-Reply-To: <20260710-romantic-dashing-gecko-e31a98@sudeepholla>
CC: michal.simek@amd.com, cristian.marussi@arm.com, sudeep.holla@kernel.org,
  linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com, vincent.guittot@linaro.org,
  Souvik.Chakravarty@arm.com, alexs@kernel.org, andy@kernel.org, brgl@kernel.org, bmasney@redhat.com,
  dlechner@baylibre.com, dzm91@hust.edu.cn, festevam@gmail.com, Frank.Li@nxp.com, linux@roeck-us.net,
  jic23@kernel.org, corbet@lwn.net, lenb@kernel.org, lgirdwood@gmail.com, linusw@kernel.org,
  lukasz.luba@arm.com, broonie@kernel.org, mturquette@baylibre.com, nuno.sa@analog.com,
  pavel@kernel.org, peng.fan@nxp.com, kernel@pengutronix.de, p.zabel@pengutronix.de,
  rafael@kernel.org, s.hauer@pengutronix.de, skhan@linuxfoundation.org, sboyd@kernel.org,
  ulfh@kernel.org, viresh.kumar@linaro.org, si.yanteng@linux.dev, arm-scmi@vger.kernel.org,
  imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
  linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
  linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: sudeep.holla@kernel.org
Message-ID: <mhng-8AE63289-05A8-49D5-B38A-F5AA1D56C2E8@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

On Fri, 10 Jul 2026 01:59:04 PDT (-0700), sudeep.holla@kernel.org wrote:
> On Fri, Jul 10, 2026 at 10:46:15AM +0200, Michal Simek wrote:
>>
>>
>> On 7/10/26 10:38, Sudeep Holla wrote:
>> > On Fri, Jul 10, 2026 at 09:42:09AM +0200, Michal Simek wrote:
>> > >
>> > >
>> > > On 7/10/26 09:35, Sudeep Holla wrote:
>> > > > On Fri, Jul 10, 2026 at 09:03:32AM +0200, Michal Simek wrote:
>> > > > >
>> > > > >
>> > > > > On 7/9/26 17:56, Cristian Marussi wrote:
>> > > > > > On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
>> > > > > > > On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
>> > > > > > > SCMI server from different architectures than ARM that's why remove
>> > > > > > > ARM/ARM64 Kconfig dependency with also remove ARM from description and
>> > > > > > > rename folder to reflect it.
>> > > > > >
>> > > > > > While I understand dropping the dependency on ARM (I always wanted to do
>> > > > > > that and test if it worked at all on some otehr archs with QEMU), I am
>> > > > > > not sure about the whole renaming party ? why is needed just for
>> > > > > > cosmetic reasons ? it is at the end an arm originated protocol so I dont
>> > > > > > see it as a being wrong to be named as such even though used by other
>> > > > > > archs...I have not really strong opinion on this...
>> > > > >
>> > > > > I have been in CC on U-Boot RPMI patches which got to my attention because
>> > > > > I don't want to have another interface for MB-V(riscv-) running in
>> > > > > programmable logic and have another server in the system doing the same
>> > > > > thing.
>> > > > >
>> > > >
>> > > > Ah that's interesting. I wasn't aware of that. I still agree with the move
>> > > > in principle, but how does that align with these:
>> > > >
>> > > > drivers/clk/clk-rpmi.c
>> > > > drivers/irqchip/irq-riscv-rpmi-sysmsi.c
>> > > > include/linux/mailbox/riscv-rpmi-message.h
>> > > > drivers/mailbox/riscv-sbi-mpxy-mbox.c(Should be fine as it is just transport)
>> > >
>> > > I am having separate discussion on u-boot mailing list about RPMI and it's
>> > > usage on non riscv architectures because one raised argument was that it is
>> > > community driver spec compare to SCMI which is owned by ARM. But IMHO only
>> > > for riscv.
>> > >
>> >
>> > IIRC in LPC 2024, we did discuss opening up SCMI so that RISCV could use it as
>> > is instead of copying quite a lot from SCMI for RPMI in some closed groups.
>> >
>> > Here is the summary we got from couple of RISC-V vendors at the time:
>> > "
>> > RPMI is comparable to Arm SCMI, but it includes RISC-V-specific services such
>> > as HART State Management, CPPC, Management Mode, and RAS Agent. The SBI MPXY
>> > extension enables secure and non-secure system partitions to exchange RPMI
>> > messages, allows an M-mode RPMI transport to be shared with S-mode, and lets
>> > hypervisors virtualize RPMI for guests or VMs.
>> >
>> > RPMI development is already well advanced, with much of the client-driver work
>> > implemented in OpenSBI. Supervisor software can access selected RPMI services
>> > through SBI MPXY. A permissively licensed reference implementation, librpmi,
>> > is also available for platform vendors.
>> >
>> > RPMI was created after evaluating Arm SCMI, mainly to support RISC-V-specific
>> > requirements.
>> > "
>> >
>> > I didn't pursue it any further following some of these followup discussions
>> > post LPC 2024.
>>
>> interesting. It looks like that they even didn't try to ARM about it.
>>
>> >
>> > > >
>> > > > Now I feel we need some alignment before making $subject move.
>> > > >
>> > > > > Based on that we had discussed about it with Vincent and Souvik (we missed
>> > > > > you there) about using SCMI on non ARM platform and both of them didn't see
>> > > > > the concern to be marked as ARM only protocol.
>> > > > > Truth is that some of protocols have ARM in description, file names, etc but
>> > > > > some of them not. That's why I think it is good time to sync it up and
>> > > > > enable
>> > > > > running this protocol on other SOCs.
>> > > > >
>> > > > > > ... my concern really is ... wont this full scale rename simply generate
>> > > > > > a lot of un-needed churn for future fixes and/or backporting ?
>> > > > > I don't think it is going to be a big problem because it is just git mv
>> > > > > which git is able to gracefully handle.
>> > > > >
>> > > >
>> > > > Otherwise it may end up being unnecessary churn though I completely agree
>> > > > with the git/backporting aspects. Just don't want to churn things up until
>> > > > we have some plan and further changes/users of this move.
>> > >
>> > > As I wrote above AMD/Xilinx platform with SCMI server where ARM RPU/APUs
>> > > (with multiple VMs) and Microblaze-V in programmable logic acting as
>> > > separate agents is going to be the first user. And for being able to run
>> > > SCMI on Linux running on Microblaze-V I need enable SCMI on non ARM
>> > > architecture.
>> > >
>> >
>> > Ah OK, if the plan is to just use SCMI as is and having "ARM/arm" name is
>> > a blocker, then sure we can get that done. Hope you are aware of and already
>> > considered some of the RISC-V specifics listed above and ruled out any of
>> > those as concerns to use SCMI on RISC-V platforms.
>>
>> I know that we can't maintain SCMI and RPMI servers running on the same chip
>> doing the same things. We don't have space for it and make no sense to
>> duplicate testing on it too.
>>
>
> That is very valid and compelling reason to re-use and agree with your
> assessment. If you can make it work, go for it 😉.

Ya, it'd be great if we could stop duplicating specs in RISC-V land, 
it's just a big time sink.  So

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

if that helps any.
