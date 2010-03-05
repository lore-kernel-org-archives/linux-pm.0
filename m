From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Problems with remote-wakeup settings
Date: Fri, 5 Mar 2010 22:08:09 +0100
Message-ID: <201003052208.09486.oliver__14644.7049607106$1267823521$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.1003051546370.1384-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003051546370.1384-100000@iolanthe.rowland.org>
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
Cc: USB list <linux-usb@vger.kernel.org>, linux-hotplug@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > I guess it's better if drivers don't set should_wakeup if unsure, but o=
f course
> > that's impossible to enforce.
> =

> That's the real question.  Ideally, drivers won't touch should_wakeup.  =

> How do we get there from here?

Enable it only for devices specifically designed for wakeup, that is
keyboards, power buttons and WoL, perhaps also mice and modems.
Are we far away from that?

	Regards
		Oliver
