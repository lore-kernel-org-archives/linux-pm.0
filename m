From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Runtime PM support for named power states
Date: Mon, 3 Oct 2005 10:08:30 -0600
Message-ID: <20051003160830.GA19720@cosmic.amd.com>
References: <20051002204310.GC2239@elf.ucw.cz>
	<Pine.LNX.4.44L0.0510031119380.4824-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42976087991734735=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510031119380.4824-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============42976087991734735==
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> Thank you.  It's a start, anyway.  My real question is: Is this the right 
> way to go?

My two cents are that its definately a thrust in the right direction.  The
important thing is that it makes the devices start thinking about how to
transition between power states outside of a system level event.  This is
mandatory infrastructure, regardless of the higher level policy management 
(or lack thereof) that we eventually agree upon.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============42976087991734735==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42976087991734735==--
