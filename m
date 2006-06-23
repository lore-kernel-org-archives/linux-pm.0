From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Fri, 23 Jun 2006 23:10:54 +0200
Message-ID: <200606232310.54564.rjw@sisk.pl>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<20060623091016.GE4940@elf.ucw.cz>
	<20060623194100.GA3812@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060623194100.GA3812@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>, Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday 23 June 2006 21:41, Russell King wrote:
> On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > Serial console is currently broken by suspend, resume. _But_ I have a
> > patch I'd like you to try.... pretty please?
> =

> Did you bother trying my patch, which was done the Right(tm) way?
> There wasn't any feedback on it so I can only assume not.

Sorry for that, I just couldn't test it earlier.  Works for me. :-)

Thanks,
Rafael
