From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Thu, 9 Apr 2009 16:06:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904091605080.4583__3966.69754195518$1239318758$gmane$org@localhost.localdomain>
References: <200904100057.43827.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904100057.43827.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 10 Apr 2009, Rafael J. Wysocki wrote:
> 
> I'm seeing two problems with -git from today.

When today? A number of people apparently had module problems before 
commit 97c18e2c7a8e36d2d83d50ee070314aadac73a11 ("module: 
try_then_request_module must wait").

If you don't have that one, then that might explain both problems, in that 
a "second try" would work for modules (your sound issue), and that 
compiling things in would obviously avoid it (your storage driver thing).

But if you _do_ have that, then it's obviously something else ;)

		Linus
