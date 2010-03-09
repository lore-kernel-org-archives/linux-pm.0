From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Wakeup for PNP
Date: Mon, 8 Mar 2010 23:45:30 -0800
Message-ID: <20100309074530.GB17288__42924.1306534552$1268138337$gmane$org@core.coreip.homeip.net>
References: <20100302213105.GB13499@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1003031019040.2821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003031019040.2821-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Alan,

On Wed, Mar 03, 2010 at 10:29:09AM -0500, Alan Stern wrote:
> On Tue, 2 Mar 2010, Dmitry Torokhov wrote:
> 
> > > @@ -656,7 +658,7 @@ static struct pnp_device_id pnp_kbd_devi
> > >  };
> > >  
> > >  static struct pnp_driver i8042_pnp_kbd_driver = {
> > > -	.name           = "i8042 kbd",
> > > +	.name           = "i8042-kbd",
> > 
> > Why is this needed? I don't think spaces are more dangerous than a colon
> > which we do use...
> 
> This string becomes the name of a directory in sysfs.  Having a ' '
> character in a directory name just doesn't seem like a good idea; at
> the very least it's likely to confuse shell scripts.  (A ':' character
> is a lot less subject to misinterpretation.)  I could change the '-' to 
> ':' if you prefer.
> 

We have not heard complains about this causing trouble ever since PNP
support was added (so what 5 years at least?). At this point I'd be more
worried about breaking existing users...

Thanks.

-- 
Dmitry
