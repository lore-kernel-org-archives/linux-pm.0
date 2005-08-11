From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Thu, 11 Aug 2005 09:06:50 -0600
Message-ID: <20050811150650.GG26524@cosmic.amd.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
	<20050810100133.GA1945@elf.ucw.cz> <20050810125848.GM852@poupinou.org>
	<20050810184445.GB14350@redhat.com> <42FA8FC0.5000700@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72505419100578372=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42FA8FC0.5000700@mvista.com>
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
Cc: Bruno Ducrot <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>, cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============72505419100578372==
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> I've attempted to extoll the benefits of adding these interfaces in 
> previous emails, and if after that it still seems mystifying why anybody 
> would want to do this then I'll take the heat for doing a lousy job of 
> extolling.  I've also admitted that it is primarily of use in 
> embedded-specific hardware, and of less use in x86 and in desktop/server 
> usage for various reasons (unless it turns out there's some fantastic 
> savings to be had in modifying common x86 bus speeds independently of 
> cpu speed, which seems unlikely).  In the case of x86, undervolting is 
> in practice by some folks, but yes it is risky and support for it in the 
> basic interfaces probably shouldn't be a high priority.

I would like to toss in my support to Todd, if he'll take it.  When it comes
to embedded power management concepts, a consistant theme is that people
often question the usefulness, redundancy or complexity of a solution.  This
is perfectly understandable, since such a huge majority of the power
management experts and users are concentrating intently on x86 desktops and
servers.  Thats nobody's fault in particular, just a natural result of a
Wintel world gone mad.

At the PM BOF at OLS, when we started discussing runtime management, somebody
mentioned that one of the problems with RTPM is the complexity.  As an
embedded Linux developer, I hope I speak for the entire embedded community
when I say that we welcome that complexity - we are willing to do anything 
we can do to squeak every single millivolt out of our platforms.

But as a laptop owner, I can see the other side of the coin as well - I don't
know the specific voltages that my laptop uses, and I don't want to know. 

In short, we have different goals, but our hearts are in the the same place.
These same concepts are going to show up more and more in the future, and
eventually somebody is going to start shipping less then optimal solutions,
just to get something to market.  This list can either lend its expertise, or
complain when somebody else gets it wrong.  The second one might seem more
fun, but I hope we can agree its far less productive.. :)

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============72505419100578372==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72505419100578372==--
