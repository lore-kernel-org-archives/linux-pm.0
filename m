From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: what handles disk drive(s) shutdown?
Date: Thu, 9 Feb 2006 21:50:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602092146530.24417-100000@netrider.rowland.org>
References: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32563788264226234=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============32563788264226234==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 9 Feb 2006, Randy.Dunlap wrote:

> in Documentation/power/devices.txt, I read:
> 
> <quote>
> System shutdown -- at least disks need to be spun down, or data may be
> lost. Quiesce devices, just to make life easier for BIOS. event =
> FREEZE, flags = SYSTEM_SHUTDOWN
> </quote>
> 
> Is this actually done somewhere?  I can't find /SYSTEM_SHUTDOWN/
> in any kernel .h or .c files.

Just about everything concerning the flags in those documentation files is 
fictitious.  The flags field doesn't even exist!  Right now there's 
nothing but the event field.

I guess it's what Pavel intended to implement eventually.  That doesn't 
mean the final version will actually take the form described in the 
file...

Alan Stern


--===============32563788264226234==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32563788264226234==--
