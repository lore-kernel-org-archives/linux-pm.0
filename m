From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] Power Management Policies
Date: Fri, 22 Apr 2005 22:05:50 +0200
Message-ID: <20050422200549.GF475@openzaurus.ucw.cz>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86551143023956789=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050418093919.37bb40db@cosmic.amd.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============86551143023956789==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > On the other extreme, we could allow userspace to configure every
> > timeout value, and other policy attributes. 
> 
> With regards to this specifically, in addition to the
> other extremes you mentioned, we also have two different types of
> systems. On one hand, we have open systems, with many different options,
> and plenty of PCI and PCMCIA slots to keep adding new devices. while
> on the other hand, we have closed systems such as cell phones and PDAs,
> where the number of attached devices stays fairly constant.

Notebooks and PDAs are not that different. Both are mostly closed with pcmcia/cf/sd slot...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============86551143023956789==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86551143023956789==--
