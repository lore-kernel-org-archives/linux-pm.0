From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] AHCI: speed up resume
Date: Fri, 04 Jul 2008 17:10:32 +0900
Message-ID: <486DDAF8.6050605__36828.3452386551$1215441000$gmane$org@kernel.org>
References: <1215074882.3214.15.camel@rzhang-dt.sh.intel.com>	
	<486D8F88.9000904@kernel.org>
	<1215149537.3068.18.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1215149537.3068.18.camel@rzhang-dt.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> During resume, sleep 1 second to wait for the HBA reset
> to finish is a waste of time.
> 
> According to the AHCI 1.2 spec,
> We should poll the HOST_CTL register,
> and return error if the host reset is not
> finished within 1 second.
> 
> Test results show that the HBA reset can be done quickly(in usecs).
> And this patch may save nearly 1 second during resume.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
