Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2D50AC3D
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796041; cv=none; b=Lg8otv5GEUe6hpxhzc8++jNUNrjwuebsBofK0aanuV/0TfwkrhOVCeURMyPemJJV56IYDYL5ZNSzeKI6Jv2faBQlLQfAWDxqOqkySVRpdSPZfTyTozvkJCXDwmeMIy4TX2i1DVsbOTeO4FATF70EQW/r1BzHq+2vxgVXQ1FsYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796041; c=relaxed/simple;
	bh=/hqGRwDn3gn18VWIUgAvVWOCvccvyWq95BKIpNRdFtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXQTNCR2vo5R9SaSeAqa7nuSr6xD3KTCAdPcQxUDz30K2mK0p+AGRvHsdx3M8Z9ER8olbtv+Nu8tLeb+XqasgLsOUy9gf7IRpaCSYAw1YrV8BzuydvFSheSsWtkcRW0Oh+RqsO16w8sD6M/fFfqqHAHf6h0RU9ktsyci9YUtkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cBK2c+zG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cBK2c+zG"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9103be3b3d9so56668636d6.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796038; x=1789400838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=cBK2c+zGYEBMAfyAYJS/QQdrfqd7izx/+Cg8hDXP1IONC0/uGrnS2Wo6s7Gyw03PeE
         bmy7F1sQdHddDujNvmb67dvr3s77U6jZ+JI0u9nBlughfKTWoYTJgfg/PDSCQ8m84C9J
         Hdg52YFcBmofcI5F4cLltT+Msszbmvno0MrvrR6DziA7CChNrUpzEBgBT8Tj+S366Mgh
         HsAu5NOKRTz2LqRpaA82xB3X294iKQt6TrXFv+zSiicPYXJgRrAfzLneQ3xikl9jdnOC
         5ijNYANwE5rCujgJ+U12jnsedELi7ao/rajeeB7tucCXg4C3hhaU2YFtUZ7/ycknJNIf
         6TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796038; x=1789400838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=cdCvu2o1JM5W5jHPeb3oTBo+MyMWAZOBSpwD3DitVNEsiKCzHehWvLVIjTGMO2kC2J
         VgYfgdX25QwwWxXMcjH4VUClDl6Y7PMa2w1kLbIQhFzUdiLElzflTRxgn6ydKIbfh0m0
         AcK9slBSNZZu3hRkFkXf/fwvEFcrwKKglfK6xdDYwSC8VGt6/V82haHXjZZh5t5oOMf3
         xmHGkVXyUDZUv3BfgQa+oBb15eyfhoKMB3rpXayxb4thRDl8gpGYryMPJC/uhpoeF1j0
         tCz8SgejqqBI+UMKf9tOXi48r3nQsBVN/732QgYxZY1h+feGLCWe77TQSSg6Z4mJ/YQv
         XhtA==
X-Forwarded-Encrypted: i=1; AKwUvByoMjVE+4x0+pJSgJlyKhwK0oxY+9Mqa8LVGvyn8pNDZ0MtgD/4epPAHhIQYhZC1PHgjgPQAl4ODw==@vger.kernel.org
X-Gm-Message-State: AFuF++mFis8V6nIGWFsIGvYTbrnFy/HFvFMCxjMeTP56Mk74u+jPAJNj
	sLhfyFSnmjuAV+u1pcEavTwYZjx02XFj60NZkhYwGOYOE6azlEW8tIUspgtKZJF9ARw=
X-Gm-Gg: AYBFou2uTgqH5W6CX9gP1QNv1271Ui8Rdm448/juT0L1kqF+ZhVia/zGmINPLO7euoa
	KdwiOXLeVCRXRbTB3nnW1PAt9Psl3VNvviplzxTXsDlcaKAXsMtOB3hCVsJAmrr2Xs3n76C2YLs
	ioxOEYJVWWh67Bc5+DAcHUEf6TOaV0zTokOwlrxhEF4evHoNlRwauMCyfJQpuU0F/Km3MGdZyv1
	LMalxHm03xu9jHa8bN50KDdNZTsAGdYrqUXX/kETro13xCEkZDU+jgHnWYToYx/D5TvhKUnejW4
	8dxRFexZ9QGi4/lN2OveE/t6UasTBBYpGF0+nC8bK7iaXvvuvFCfk/ZYMAcCzQqZipwYwOKsq2J
	D73HhYuc4UWyNg5YR+RFqwv2rURRcd8yBYJ+NVZPRJcktwq3Y8l/ZO7MOZM9dwsl3x3uI4Vk5Np
	OnyUSrAtwWO8cQ4GfW2wzGqamkCXSXgxNp+hz70Q7lGeWuFbQq9IHqwnxBNDpisy5REKsiqi5r/
	JFjPsKHODWJwevCn1vPgtvTOXEIDTFwUZ84G1IXMFoA
X-Received: by 2002:a05:6214:2b87:b0:910:4861:43ac with SMTP id 6a1803df08f44-910486145aemr202492056d6.5.1788796038419;
        Mon, 07 Sep 2026 08:47:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm94174406d6.43.2026.09.07.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:47:17 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:47:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, "David Hildenbrand (arm)" <david@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7cd8OigImcG6eX@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:32PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rculock() macros, which scope the RCU read lock
> to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

