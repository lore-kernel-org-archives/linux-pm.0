From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Adding board access to struct pm_ops pxa_pm_ops
Date: Mon, 10 Oct 2005 19:06:45 +0100
Message-ID: <20051010180645.GB9811@flint.arm.linux.org.uk>
References: <1128868700.8704.66.camel@localhost.localdomain>
	<434AAB04.50806@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12636471648981251=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <434AAB04.50806@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Todd Poynor <tpoynor@mvista.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

--===============12636471648981251==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 10, 2005 at 10:55:16AM -0700, Todd Poynor wrote:
> cc'ing linux-pm list.

And thereby breaking the etiquette, thanks.  For folks on linux-pm,
please drop the linux-arm-kernel cc:

> A cell phone maker has expressed interest in 
> approximately the same thing, in their case to barely wake from suspend, 
> update the time and other display info, check to see if they need to 
> fully resume, and if not go back to suspend.
> 
> A new optional pm_ops wakeup hook, called after the enter_state callback 
> returns, that can veto resume and go back to call enter_state for the 
> previous state should work, yes?  This hook would be intended for 
> system-specific customization (should always be NULL in generic board 
> support), and would avoid global access to pm_ops and the fragile 
> process of inserting new routines into the suspend/resume callback 
> paths.  I can float a patch for that if that sounds suitable.  Thanks -- 
> Todd

FYI I don't like the patch below - it makes working out what's going
on rather problematical.  Override the registered pm_ops completely
instead.  Don't fiddle with structures you don't own (thereby breaking
the modularity of the code) by making them global.

--===============12636471648981251==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12636471648981251==--
