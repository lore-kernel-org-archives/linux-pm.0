From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add a printk_init variant storing format
 strings in __initdata
Date: Wed, 4 Jun 2008 12:43:36 +0100
Message-ID: <20080604124336.578d86ae__43243.8177326278$1212580926$gmane$org@core>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
	<20080604011607.15dec5a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080604011607.15dec5a7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, Andy Whitcroft <apw@shadowen.org>, mingo@elte.hu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > When using printk from __init functions it would be desirable to place
> > the printk format strings in __initdata.  Add a printk_init() variant
> > which does this.

Russell played with this years ago I seem to remember and broke the ARM
gcc in the process. If we have any compilers generating near pointer
references for string constants then suddenely hiding them in another
section is going to be interesting.

> Wouldn't it be great if checkpatch were to detect
> fail-to-use-printk_init() in an __init function?

Can we have a 'correctpatch' to go with it someday perhaps ;)
