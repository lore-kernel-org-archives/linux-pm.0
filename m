Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893405;
	b=TspJcQ13BWsjgWSK7iRZlgJubgWrH07teAZpgjA27kpyx9QQXye17fjejbeFMeHgReJJ
	 Tk1FvceL2OSBt3+FOCMHfk/jjrquz/OQpfB3706+o3ZUPrMKsMM6ZK0uf/cHvkA+TlK83
	 ZXotAHGtGqcbxCU7iByxfRzNYlMSk6uWMtMxxZDf2rraQSnFSNT5BncicScshr88cee2B
	 CDXEO4lLkAOPXUlarxexYObJOfYAY8Q+sHCuxxqbDgTERRCQKOE6byXteluXqKfwW/NpU
	 BeHWjy4MaN3epo8t/a9nj7vUiCODC/SHtVGYfuRsGyioGZ6TQsQsAhpt8b7fnbNVxNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
	b=QL44HtJnAWMHwzR4P9d2u8iiOYXw1fS2TmBgxR25nGRUKp3/LK14o208aV1dwax5kZ0T
	 yzjytUrnat2AFlQwnnQ0ECPWxikcQp9+SY/UxSz8ehyhU/npPyvgqoRbtPtDscFPRusZO
	 FEGmlfkA7UmNu8n5Sb2WSHM6dQv6i65cfX5cdM34esZsYyIIXFmwcSdHbAuBlbze2Ad3B
	 90IvFevfZmoLhlK3eKxjIgHD6gJCcGb5bccrdGgcas1ar9ppzyRHDz7BkfyZjh5AoLul/
	 WfX4g3MWblFe/ohH8O6hjbXsPeGQ9JPuHmr8mLjV6xE1+pjER5M4oqxUdEftzjvX2LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jx5pGRxE;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF88606A332
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CF88606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jx5pGRxE
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a3c08d6928so5929377c88.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794893404; x=1795498204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
        b=Jx5pGRxEn/r5S4/3N0yhzLTza9aPjKIstDeFKgSij5nK+aSlmAC86wdabmnPytAen/
         kxVwbjGlPYVnJBopzfjTvdRf0AGe/mTwz9tkopS2yB958I883j92ZadhqHMX4+Yjexf2
         Vz0NXVbpAR1i7P8EAYmA6xDiuz+JVh2Zj1v4OF/C6tf2VYGfjVaVcAQaqwWBIv3rWwOq
         qebu8KuRr+cQ/mJQ9ETfZXkafs/HTLzQDS1LwuJsLZsxEq8T1xRUxCWCEZ+3Y9Or1I7t
         cPXn2Y4iVfSC6C0gTujGvgEaJr1XTp2sFgNww6DJ5dtiHVV8biEK8U9cXdxZb8dZwAJr
         WsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893404; x=1795498204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
        b=052JpP8seVmMGKWVhKuYc3vTbyxXX71yUqQPTlwE4HIwiJoaCDDTaxR+ozFCgM1Kpy
         Q3VF7SHLSt4PEOnoqXk82OjKdzuIi1ugGo88ZxbSxkpZYNKa6QPmjiVvH+WBoQgj6DSC
         hMR3y3gCkAkJGmgpi+FmYxLL6ySnMUNseSuB8qrWwQ1reLpdA7IdP8JCqB+F5Wcaao+c
         6b9tl1mjsK/lugLBQGf9z+wxVeuckEsOf+7hK/NtLr6Zs6CPUccancOLGb5a9N/DEp52
         /DjBR04BTGsLhQVQVDVcB07OpQceG0NukoremDFj10QfGOEWdCL0a4YagXos2CqznFLf
         sgkw==
X-Forwarded-Encrypted: i=1; AL+hErGFmCw7O1jQLv4D6K8laC7m9vcWArzCB9vvE1tmYmqX1JxRT9IFftXWSSlx7hGXgbbweDomtffuUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8h5R8q+HVNq74ZNhUKfZvJrv0OfG5D57+hVzZx7MV3thI8eFov
	W8sCX+2bVtocx7WV6MXcR8+sslFhl2QPeUevP8BDwaz/ROihRsYyRE3hWvMGJB8WQHA=
X-Gm-Gg: AYBFou309FekwyfZe3X9sG854TuBoGJu89TkPMazsR/JFYjPzj14N5hzZ7+RkFg+aO8
	jmCILCPwZfD0wfEHGCggD2EJSxHlxJrZ0NFnKfVn37z3BnS2MNlSP4aTka0XKYU44hcsBanS5Uh
	dqC7w/G1M/yz7V899XlNPasAQMQ/6c8UWhzIw+JSD/2k1E2ErbjQmDluRVcr/qp8jNUMnY3id57
	GxAk0Q7shwqj9lc3MjtKiIB3J5o/jOxazH84zpE2fOwfdQ8yaSaYS8KpAZGJ2ctqaeWvrKrnEV3
	qjwC1dQ8u0FwhYSh+0bg8Lpey8QktWrc+zR9YvuGcUTGp8WKuuWWegg+Q2X0sHvFn73dmP5E0V0
	d0hvKQKZPzT/LrJJJE8hWMSriBxQh1mHA5tY1MB824z3sjFyJj2C0EMF2XsL9huuScudcvHpOfY
	IC/igQAVDDaqd/lCESZKpTAgRTcDCfZnlE+/Tca/oREzI6pxBIlG/7fW9QZWD8nQ6m2s/Bgku1s
	nsDxDdAxxI9YOuEtLKLBB+ggrpibEQhaRddTLqutMD2UKrd6tk0LV9E1OshHDrxjAheeD2Oq4xF
	InurU9JhSc5yDIGonQw1WW7nRAqStA==
X-Received: by 2002:a05:7300:e9ce:10b0:368:7c2d:a612 with SMTP id 5a478bee46e88-37966c4738fmr12899653eec.10.1794893403702;
        Mon, 16 Nov 2026 21:30:03 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm77630203eec.20.2026.11.16.21.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:30:02 -0800 (PST)
Date: Tue, 17 Nov 2026 11:00:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gyokhan Kochmarla <gyokhan@amazon.de>
Cc: Shuah Khan <shuah@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] selftests: cpufreq: Disable the runner timeout
Message-ID: <avvmWA6YX2I-ovJy@vireshk-B250M-D3H>
References: <20261113163951.1510082-1-gyokhan@amazon.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113163951.1510082-1-gyokhan@amazon.de>

On 13-11-26, 16:39, Gyokhan Kochmarla wrote:
> cpufreq_basic_tests() reads and writes every policy file, offlines and
> onlines every non-boot CPU five times, and then shuffles all
> frequencies and governors of every policy. The amount of work scales
> with the number of CPUs, but the test runs under the default 45 second
> kselftest timeout.
> 
> On large systems the hotplug loop alone does not fit. On a 256 CPU x86
> machine each offline/online pair takes about 0.5 seconds, so the
> reboot_cpus 5 step needs more than 10 minutes. Even with the timeout
> raised to 180 seconds it is killed in the second of the five loops,
> and the frequency and governor tests never run:
> 
>   not ok 1 selftests: cpufreq: main.sh # TIMEOUT 180 seconds
> 
> A larger fixed value would only move the problem to the next bigger
> machine. The basic test has a fixed number of iterations and does not
> wait on external events, so disable the timeout with timeout=0, as
> ftrace, timers and net/forwarding already do.
> 
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
> ---
>  tools/testing/selftests/cpufreq/settings | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 tools/testing/selftests/cpufreq/settings
> 
> diff --git a/tools/testing/selftests/cpufreq/settings b/tools/testing/selftests/cpufreq/settings
> new file mode 100644
> index 000000000000..d3e07370a7e4
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/settings
> @@ -0,0 +1,5 @@
> +# The basic test hotplugs every non-boot CPU five times and then walks
> +# all frequencies and governors of every policy, so its runtime grows
> +# with the number of CPUs. No fixed timeout fits every machine, and the
> +# test always terminates on its own, so disable the runner timeout.
> +timeout=0

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
