From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 01/12] drivers: base: cacheinfo: move
 cache_setup_of_node()
Date: Mon, 15 Jan 2018 12:23:49 +0000
Message-ID: <20180115122349.GA5473@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-2-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-2-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:09PM -0600, Jeremy Linton wrote:
> In preparation for the next patch, and to aid in
> review of that patch, lets move cache_setup_of_node
> farther down in the module without any changes.
> 
  ^^^^
s/farther/further/

Makes sense

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
