From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 03/12] cacheinfo: rename of_node to fw_unique
Date: Mon, 15 Jan 2018 12:36:58 +0000
Message-ID: <20180115123658.GC5473@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-4-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-4-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, austinwc@codeaurora.org, viresh.kumar@linaro.org, Palmer Dabbelt <palmer@sifive.com>, will.deacon@arm.com, morten.rasmussen@arm.com, vkilari@codeaurora.org, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, lenb@kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Albert Ou <albert@sifive.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:11PM -0600, Jeremy Linton wrote:
> Rename and change the type of of_node to indicate
> it is a generic pointer which is generally only used
> for comparison purposes. In a later patch we will apply
> an ACPI/PPTT "token" pointer in fw_unique so that
> the code which builds the shared cpu masks can be reused.
> 

[Nit] as used in the commit log, I prefer fw_token over fw_unique.
But I am fine if you/others prefer fw_unique.

Otherwise,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
