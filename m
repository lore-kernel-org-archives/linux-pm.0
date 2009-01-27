From: Pavel Machek <pavel@suse.cz>
Subject: Re: ACPI problems
Date: Tue, 27 Jan 2009 23:53:58 +0100
Message-ID: <20090127225358.GA19343@elf.ucw.cz>
References: <OFB501AC29.DA72593B-ON65257545.00363AF4-65257545.00363B0B@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <OFB501AC29.DA72593B-ON65257545.00363AF4-65257545.00363B0B@LocalDomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mohd.adil@tcs.com
Cc: majordomo@vger.kernel.org, linux-pm@lists.osdl.org, acpi-bugzilla-request@lists.sourceforge.net, linux-pm-devel-request@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed 2009-01-21 15:22:20, mohd.adil@tcs.com wrote:
>    Hi
> 

>                This is my first post to the list. Hope I will find a
>    solution.

Please avoid using html on the lists.

>                I am trying to develop a new functionality using a Sun
>    alonso Quad Core blade (x86_64) architecture.
> 
>                 The linux distribution which I am using contains a very
>    old acpi driver (02/09/2005 probably acpi version 1 compliant)
> 
>                Further, the BIOS I am using is an AMI BIOS.  I am fairly
>    certain that it is acpi version 3 compliant.

Famous last words.

>                 Now, I am facing two problems here.
> 
>                1)  I am trying to evaluate some namespace control methods
>    which are setup in sytem DSDT.
> 
>                     Functions are :
> 
>                      [1]\\_SB.PERB (should contain memory location
>    address) and
> 
>                      [2]\\_SB.PERL   (should contain length)
> 
>                     This some information passed to us from BIOS which is
>    required for my development.
> 
>                     I am using acpi_evaluate_object to evaluate these
>    functions. I dont see any error in executing the evaluate
> 
>                    function call. But they evaluate to zero.

Hmm, this is hard to debug without seeing the source.

>                 2)   The second task I have is to put the system into S3
>    (suspend to ram) state.
> 
>                       While doing that I am experiencing a problem. Every
>    time I write
> 
>                        echo mem > /sys/power/state
> 
>                       System hangs at METHOD_NAME__PTS method. There is a
>    related bug in
> 
>                      new acpi driver related to this function. But since I
>    am using a very old driver this should not have
>                      happened.


Which kernel version?

>                      Just for added information : I dont really care about
>    resume from the S3 state. I dont have video card.

You want to suspend but don't care about resume...?!
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
