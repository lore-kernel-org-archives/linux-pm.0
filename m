Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47950AC3D
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795752; cv=none; b=ItjzCTH3SIemF8F/2ClD3gN0Up38VLEcKLm4qnAqNR7rR6WyIKaKhYgDUnfIegvgn8q3jEz+ZO1PwlyOlv2VtQUS1fo1axVfjXrjTHvLY2eKH1+kb4gleqxqfVlC40QSsw+2GRaBsTmX4NxXNQU9PIdqpGzQ2RcwHe1U0mEXVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795752; c=relaxed/simple;
	bh=+OOqmbaWCc+bj0drcgwfudfjBi7gFVexonNebA007r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSaYK4lFNsH6fD781Q+QGQ+jYNGBQMMBuQBRkFqrIbuF3TePWgDBVGg8wJXAq2cEFkVQjTj0qqbh1DJxN5IYLML2wE98EN/hYgtgFiN46eVv2NDqhbjrPEHHRqZ7CuGCOTD/6/QegJh+DAxVth9W+OJxS3sIU+DincF8FzwetUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FdRMqgpf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FdRMqgpf"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e85499ffbso281846285a.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795746; x=1789400546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=FdRMqgpfx1J0zFlqgT+7WgNaj4cSat5/uXgUrOcggIxlg16d1IM6j5fzpoJdfxjB2P
         /9rUsuFGSVHMph0igjnLvLn8ySpk+gqUvrbN2vFaavz5LgUAygmQgsPjMBRC7VanS43W
         JATad4DlLfdmil2YdGkAk7tfgNrN3SfEqLlxTPx+BvyXWvyr/1Ny4qAc9W2iZ6xpxYhN
         3K0/WZ5iPJtbKqRjbXrV42h3dY+YXtAJuM2JWde/5KyxEbZBHxotsnD3mqBpV8K/mpt0
         eO0NVTl1ECtQ1D0rNaVQ1r0m1zbGZZIhGn0fLez/Vrp9QfQSJWdVs2a/JZrDUaX1hpvF
         3YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795746; x=1789400546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=Z51GkSxt+u080OTShWrBkMGlmDaKCt4wWAfXhQtxw6DAz7BocbWQ4Gh+BR7KQxZjHo
         DsCagPB2ldbMQsIxzVbdaeX9wFz7gCQ4ET3Nc3sZP4enXk/3WexpTRxzb4PtuXt0X+BZ
         xFtQlblfE3FviHe9+z3CfLha2nhzpkLgWD9sK+ujUXEofrDQlKct1V1TkSD3rB0C4em/
         o/cWigaFbSiqGKp6X9e+Dod6+f5lCwsFBpvERFrW2LDGudT6UC+zpbpYUr0gblwoDjPE
         j5VdPOvdftiKfPc9cpRC4EfOTJgh6tKZvUseVlKMZpxOxxvTzFp67iwHrAmCF6gwsIW4
         k9AQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoUmApAaFfA0ii5gKmm+3ZMSC39iNidNErcWtbKDTGXUbe/llsFn11soXNO4j0ATA+OL41Zemr+w==@vger.kernel.org
X-Gm-Message-State: AFuF++mMA/DQ4dDe4vhRcKT6YAdMYXTkDE6JZ98K4PhTg13/yWs/z2Wx
	pfCBzL8WTPCZFubrOTwsD8C4tlx0N9LM8BUvF8D481C9t2+V9manh5KiWBG/G3Bei+U=
X-Gm-Gg: AYBFou2M0/Pi2y9yiZ1V8CgPGSTqq/zcCNA8vp17K5SonqRhjxw8d0DmxH+O03JeEU/
	i7YxQB8nCIlcbGG9WsRb4wjXqUOzucWy/JJQSK5z/oJ/QLAOUSCAIVAdLJQ819HiLSKCh5bbVZG
	EPZWF2/wxlAtT/edUKS8ROkfT+z72Grnn1q3LiF9qXTwF2SUP0wUg03pGMnE0zIU6Ziu+244TQi
	u2lWKNM5RVAPeK9Y6AsIa1adJL5LFPqhsdAR0eINaGrGyKOw4Wrp3khN8z0ecQdPqD9R8TIWlXf
	Krrdu3BiaYrwE0gRJcn+NFzwlnEBJV49u5J5dy8mKZToq5MevHDR147jAIexhvqetE3/lV4/nIx
	3iNPTbr4tJ1c3u0WgEIq/ehl+C13LuYOJrbHZJmBTjUNWq6c3SZZxBfXHAgsCnzcDDo7VxXcsEh
	Zxj6ttf9cGNTU8NXN+qxzTkILnNNvEhd+8l5nSQpcSphS1YsYXBC3akpUOKj427/CKJJ2qdyBOC
	8Sewu6stpI7rOsiBcqiXOlzGcHeX/Ey+Ja+XTi2W2bu
X-Received: by 2002:a05:620a:aa14:b0:939:6c2a:24fd with SMTP id af79cd13be357-9398031b73emr2041569285a.9.1788795745703;
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm95118286d6.14.2026.09.07.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:42:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yi Tao <escape@linux.alibaba.com>, 
	Michal Hocko <mhocko@suse.com>, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, 
	boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap7bPSbO7UvFSwPf@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:27PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Lorenzo already picked up the nits, this is really nice otherwise.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

