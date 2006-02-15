From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend-to-ram fails resume.
Date: Thu, 16 Feb 2006 00:33:01 +0100
Message-ID: <20060215233300.GB3490@openzaurus.ucw.cz>
References: <43EE824B.20609@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66893308655644756=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43EE824B.20609@superbug.co.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============66893308655644756==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> "hibernate" and restore to/from disk works fine.
> I have been trying to resume after running a "hibernate-ram" script.
> Just using a text console, no X.
> 
> I attach a log with comments in it.
> I have a Nvidia FX5200 video card.
> 
> After resume the display is blank. ping works from a remote machine, but
> ssh does not work.
> 
> What can I do to help diagnose this problem?

get video to work - see Doc*/power/video.txt and see
what are last messages on console.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============66893308655644756==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66893308655644756==--
