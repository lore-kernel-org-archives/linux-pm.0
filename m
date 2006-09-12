From: Greg KH <greg@kroah.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 20:26:37 -0700
Message-ID: <20060912032637.GA27397@kroah.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<991df5640aa53989f0801feecf46c979@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <991df5640aa53989f0801feecf46c979@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 11, 2006 at 01:25:42PM -0700, Matthew Locke wrote:
> On Sep 11, 2006, at 1:06 PM, Pavel Machek wrote:
> >And IIRC Greg's last question was "what is it good
> >for?".
> =

> That was a long time ago and again many people from the embedded =

> community have provided lots of answers.

I'm still not convinced.  You can't break the current cpufreq interface,
and to claim that it is irrelevant is just ignoring 95% of the Linux
market right now :)

So, you all better work with the cpufreq people, otherwise this code is
going to go nowhere.

I'm with Pavel here, in my opinion, he is correct.

thanks,

greg k-h
