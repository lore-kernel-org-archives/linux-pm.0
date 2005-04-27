From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Management Policies
Date: Wed, 27 Apr 2005 08:57:17 -0600
Message-ID: <20050427145717.GA20602@cosmic.amd.com>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
	<200504270722.31321.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74707309134705779=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504270722.31321.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============74707309134705779==
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 27/04/05 07:22 -0700, David Brownell wrote:
> I don't see major vendors wanting to move away from "closed" models
> at the lower end, or in fact whereever they have the power to dictate
> customer "preferences".  (The latter case is also known as a "market
> failure", except by radical corporatists...)  But for higher end products,
> or when customers truly have (or need!!) choices, then "open" is more
> usually the answer.

Indeed.  Really, my point was that massive userland based configuration is
better suited to systems with known configurations and vendors motivated to
spend the time and expense to tune the system.

As the system configuration opens up, it becomes less likely that the end user
will be willing to go to the same effort.  When you hit the desktop/laptop 
market, only the very uber of geeks will even consider it.

Which is why I think that userland tuning should be an option, and not
mandatory.  A wide majority of the users across the Linux spectrum might 
not care what the wake up latency of their NIC is, but I think that there are
enough that do to make a userland configuration framework useful.

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============74707309134705779==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============74707309134705779==--
