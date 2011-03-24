From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 4/5] x86 idle floppy: delete
	disable_hlt()/enable_hlt()
Date: Thu, 24 Mar 2011 08:58:25 -0700
Message-ID: <m239mcv7by.fsf@firstfloor.org>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<fb07f62522099f5d3f2b7aa6014329d716081b62.1300950095.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <fb07f62522099f5d3f2b7aa6014329d716081b62.1300950095.git.len.brown@intel.com>
	(Len Brown's message of "Thu, 24 Mar 2011 03:08:27 -0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:
>
> floppy.c said:
>
> "disable hlt during certain critical i/o operations"
>
> x86/kernel/process.c said:
>
> "This halt magic was a workaround for ancient floppy DMA
>  wreckage. It should be safe to remove."

AFAIK it was used on some 386/486s. I suspect it's safe to remove now.

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only
