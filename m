From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 17 Aug 2006 10:18:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0608171010400.6371-100000@iolanthe.rowland.org>
References: <006001c6c19e$ead15a20$4686190c@dsn.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <006001c6c19e$ead15a20$4686190c@dsn.sec.samsung.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <ikhwan.lee@samsung.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Aug 2006, Ikhwan Lee wrote:

> We can have the device power manager in the kernel and let the platform
> designers hardcode the rules specific to their platform. It is easier to
> implement and we can use that scheme right away.
> =

> In the future however, I think it is more clear to have a "power/voltage
> domain framework, and an extensible framework for system-wide operating (=
and
> non-operating sleep) states," quoting from what David said in his response
> to my message.

The second is a generalized version of the first.  However the issue of
the scope of a "power/voltage domain framework" is independent of the
nature of the userspace API for such a framework, which is what you
originally were discussing.  My point was that in a large number of simple
cases (like this one) there is no need for a userspace API at all.

To put it another way, suppose several devices have inter-related power
requirements, such as a common gated voltage source.  Provided each device
has only two power states (ON =3D "in use" and OFF =3D "not in use") then a=
ny
reasonable framework would be able to manage them adequately even with no
userspace involvement.

Alan Stern
