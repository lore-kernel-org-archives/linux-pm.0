From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 15:10:36 -0700
Message-ID: <20070322221036.GE20713@kroah.com>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<200703221302.39052.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221302.39052.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 22, 2007 at 01:02:38PM -0700, David Brownell wrote:
> On Monday 19 March 2007 2:08 am, Shaohua Li wrote:
> > This is my preliminary design, and I???d like to listen to your opinion=
s.
> =

> Best forwarded as a patch, not a tarfile...

Especially as some of us don't even look at the tarfile...

> And also, best expressed as improvements to the standard driver model
> PM framework, rather than something new.  For example, pick one issue
> that the driver model doesn't handle well enough to suit you, and
> work on patches to solve that.

Exactly.  Remember, one tiny step at a time please.

thanks,

greg k-h
