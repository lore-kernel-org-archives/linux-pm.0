From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 23:28:49 +0100
Message-ID: <20060105222849.GH2095@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051342470.17046-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0601051701560.6460-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73004677257462136=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0601051701560.6460-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============73004677257462136==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Thu, 5 Jan 2006, Pavel Machek wrote:
> 
> > Its okay with me to add more states _when they are needed_. Just now,
> > many drivers do not even handle system suspend/resume correctly.
> 
> > We are not adding random crap to kernel just because "someone may need
> > it". And yes, having aliases counts as "random crap". Perfectly legal 
> > but totally useless things count as a random crap, too.
> > 
> > Bring example hardware that needs more than two states, implement
> > driver support for that, and then we can talk about adding more than
> > two states into core code.
> 
> Embedded devices are a great example.  Consider putting Linux on a 
> portable phone.  The individual components can have many different power 
> states, depending on which clock and power lines are enabled.  "on" and 
> "suspend" won't be sufficient to handle the vendor's needs.

Consider putting Linux on a portable phone. It could contain 13-bit
bytes. Does that mean we should support 13-bit bytes in linux?

No.

People are running Linux on cellphones today, and they are running for
weeks in standby, too. And runtime suspend support is still terminally
broken, so they somehow get around that.

Do you have example of device that has multiple "sleep states" and it
makes sense to use them?

There are examples of devices that have multiple "on states". IIRC
graphics cards can already control their clock tick rates. I hope we
are not trying to solve that one here. 
								Pavel
-- 
Thanks, Sharp!

--===============73004677257462136==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73004677257462136==--
