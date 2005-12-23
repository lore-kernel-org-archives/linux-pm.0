From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime device power management in userspace
Date: Fri, 23 Dec 2005 10:17:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512231016170.15462-100000@netrider.rowland.org>
References: <20051223143047.GC16463@f192.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27297948394684934=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223143047.GC16463@f192.suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============27297948394684934==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 23 Dec 2005, Holger Macht wrote:

> Hi,
> 
> We implemented device runtime power management in a userspace application
> (the powersave daemon). In this specific case, it means to successively
> put pci devices into D3 powersave mode with writing a numerical '3' to the
> corresponding power state file.

> Now that we get more and more votes that this could be very dangerous and
> problematic because of the current kernel implementation, we decided to
> gather some more comments from involved people and experts in this
> area. That's the aim of my post to this list. Opinions are welcome!

Remember that you're likely to run into trouble if you try to suspend a 
device that has unsuspended children.

Alan Stern


--===============27297948394684934==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27297948394684934==--
