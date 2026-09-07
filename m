Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E650AC13
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795779; cv=none; b=I0OmNYYk5OGjw0wDym7hGgy/b6vQZs/XqOifnfhktC0hBkKxFSQ/5t5QSkH5u5rR8HuEIDzqPx5I/jexnI65qUbRUBwoFCjsEyowJTX1PawHsz9FLQVHUDb+Su0certHjn7l9O1UhsM/tHt7uKh78bowAr+/s5cryTVQFrkIIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795779; c=relaxed/simple;
	bh=QtFPJiEMPSV8S29PeKQ6fcZP42NUa5u8vRMrfd5W/ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSftdLqT+FEAsi69Q4/LMyK+4TpjVzvzDIeh6YpSkrJLWSGDQyr043pFrD67ME/ayZv5Spacgyto+/J4fJBEy0z8Eq9MG0c/2jPZH3WDT7dvCRLko7JtkDaeJhOSn47b8gs5ziPJNJLnmROcUgjFDByofm7TsqkMXl5NAn5timQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u5XpV1py; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u5XpV1py"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9103228ef53so42165386d6.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795776; x=1789400576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2bTzYuWDSR0jh+E6xDNAXwrxj96pyu9ESjj25Dc22Y=;
        b=u5XpV1pyWPn+OPlByOIxZ/a2rHnc7iDCTmfm4h54GPexVCJAoRwfCrTxogIXRAhxXp
         DlJKycZAJs9eBZWBy88+QzTKRvdCGMqkzbDHGiHfCNYV6dR3dYQpAabebm4ARI5VzkrR
         U0guES+JYZiNFW+FdmiUFtCD5g5u2bXLYvjHWEKC8g0SXMiMbQvYaCh6HZHONw6OoRvj
         ZipjISx4LvG5IiBC7116GrH6WdN+SwNJHuAwljjkSGdtfdz/rcKhaW+7D8mOX3ZjQt5b
         BEILZVv91ew17kfj1nj8Xwtyto+EGPIav9Cs/Tq7csxl2I1pOLHOnuFtMDQ7AksHwEIo
         o/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795776; x=1789400576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2bTzYuWDSR0jh+E6xDNAXwrxj96pyu9ESjj25Dc22Y=;
        b=h0z84MzvX4HZ4ahSATUDPwpB+FVn7qglqchONDUMpjDGNvAeJzLMkR1vj1k0T9TK97
         e9EZNNh0/BskeLxxc9pltisTt4pKOPeyDt9013Ix0T5k4LmxVX9G1JH0E2j0TZR07a08
         gsx3hjlzHtUNbB1tZfROj4MA/fqJvaHYGezLT2M9YCz7seZTNsbiouenIJtQMhP1quyT
         B/2pjD0BHTaP2LSQsSb/MzDvpPtz8vgVJIkMQBHXNdiSd/02HLM2LPVrDCT33VhPNKeY
         +xhGoQHYMm3BA3HB9yHO8CmIuAnPn6D0MfQy+XvOSlWS7yr2OI0VuhR8MtvZxuab4EcL
         +DGw==
X-Forwarded-Encrypted: i=1; AKwUvBxi30QpMVmY3xys5weM7Z0zVWarhVfaP9gQcwbx82aUuKZzjOY8/d5eHGGQ8iSRgq3EJPds8hFhNQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k3PHWaooodErGDDx4Mvq2V5YOE3uxiPx/OAjWQmXWE4Oo8TRGu
	3H317J1rEDFyItXXP1JdOLCf9Lb2TRvT4EBivLA3FGwHm0bIv4i7pfSfuyUynf7R7EQ=
X-Gm-Gg: AYBFou0kdwLWKsFnQzaI2frmkMvg5toWdKXqai9Rmkc1F9BSrcjKZ/vkxu4jSN42ohj
	EgOHoN+er+nO9+ZuixqCITQRxoFTxc2FjkngUwmIpsEmP0R2xn+u9FeTWGpOXBJIChh2+CeS70C
	VORVLp0FhoOlNC2qtUOq6FRTyH6FN9vW1uHGx+KU883P2yVsTChlq2rhheIlvHtZVKfMhaprDzd
	pa+N2xziUyFFh0ATiNlW6gr9O/0JQWzwCGYNrEK2/yyKC+QlO2b+EZko3xKdKKabaCvw13eXbwr
	zU9dgCX3u9XKnVJ88dSOj3R1moEwNjKa0S0xfwV6cTzkRNYf0Y2B++UU3egk3ZejijQbV1uyca4
	iwi/b9ubCtda8BXdyyAE2tOClU9TDjSXZySrH1y5rekdrIYPehIYsbh48/bCweash0YJaR6rInA
	nYpcv+WOH5Cwps69vK8/uWW3liKhm7aSaB4i0DJcPmt3b1GekB17rA8Dh5Dy05CrRGNPyyCmzSU
	h5sA/0Fsuj7YTnP5cpyV4gxS5ACdegjm7qAlHF0Hq6T
X-Received: by 2002:a05:6214:ca4:b0:910:5235:14f1 with SMTP id 6a1803df08f44-910523515c6mr109464606d6.22.1788795775829;
        Mon, 07 Sep 2026 08:42:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406625d9sm93010046d6.20.2026.09.07.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:42:55 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:42:53 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, SJ Park <sj@kernel.org>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, tglx@kernel.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/8] mm/oom_kill: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7bdHdjGgmIzi_P@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-3-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-3-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:28PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs wrapping
> for_each_process()/for_each_thread() loops with for_each_process_rculock()
> and for_each_thread_rculock(), which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
