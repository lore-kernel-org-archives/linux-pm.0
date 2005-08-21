From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] power trees
Date: Sun, 21 Aug 2005 19:37:38 +0200
Message-ID: <20050821173738.GD3116@openzaurus.ucw.cz>
References: <20050821140034.GA3039@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5839861646705049=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
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
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============5839861646705049==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!



> > > "states" is a list of power states sorted from most functional to least
> > > functional.
> 
> In general it's not possible to sort states in that way.  Some states 
> might permit one subset of the complete set of functions while other 
> states permit a different, partially overlapping, subset.

How common is that? We should probably treat that as two different
devices...

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============5839861646705049==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============5839861646705049==--
