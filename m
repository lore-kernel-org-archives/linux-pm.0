From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
 based hibernation
Date: Wed, 18 Jul 2007 18:04:20 -0700
Message-ID: <20070718180420.02352d4f.akpm__41071.5091893964$1184807156$gmane$org@linux-foundation.org>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184483593.1898.98.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007 15:13:13 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> 
> The changelog between v1 and v2
> 
> 1. The kexec jump implementation is put into the kexec/kdump
>    framework instead of software suspend framework. The device
>    and CPU state save/restore code of software suspend is called
>    when needed.
> 
> 2. The same code path is used for both kexec a new kernel and jump
>    back to original kernel.

I like the idea but I think I'll let people chat about it a bit more
before looking at merging the patches, OK?
