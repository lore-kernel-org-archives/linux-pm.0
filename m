From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: What woke system up?
Date: Tue, 20 Dec 2005 18:11:40 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16174661349655128=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
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
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============16174661349655128==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 20 Dec 2005, Todd Poynor wrote:

> Next in our series of wakeup patches: a consumer electronics maker asked
> for a userspace interface to inquire what woke the system up, in order
> to present different behaviors depending on the wakeup source.  This is
> to be encouraged, as it places these kinds of policy decisions into the
> power policy application and out of the kernel.
>
> So here's a quick try at adding a /sys/power/waker attribute and a
> pm_add_waker() kernel function that either drivers or board PM code can
> use to add (so far format-free) strings useful for telling what woke the
> system up.  The idea is that a buffer of these strings is cleared at
> each suspend and added to by the platform's resume path and/or driver
> resume methods.
>
> I'll send a patch or two for embedded boards showing how
> this could be used for SoC-specific wakeup sources.
>
> Any interest in this or something like it for Linux in general, or any
> other suggestions?  Thanks -- Todd

What about stashing a pointer to the device that did the wakeup, then
using a symlink to point to the sysfs directory of that device? That way,
instead of some arbitrary string, like "wake wake wake", you can
definitively know what device it was, as well as any other status..

You can remove the symlink on suspend, just like you could clear the
string, and re-add it on resume.

Thanks,


	Patrick


--===============16174661349655128==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16174661349655128==--
