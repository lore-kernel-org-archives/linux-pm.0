From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 16:25:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509271621270.1014-100000@iolanthe.rowland.org>
References: <20050927195833.GA2040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77483527032066957=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050927195833.GA2040@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============77483527032066957==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Sep 2005, Pavel Machek wrote:

> We can add a hint to pm_message_t. But for "full resume", we really
> don't know if devices are only FROZEN or if they need full reinit.
> 
> So you may get info "only frozen" and "maybe frozen, maybe it was
> powered down"; if you think that helps the drivers, just add a field
> to pm_message_t (flags), and add this as a first flag.

Okay.  Can you tell me where is the code that resumes all the devices once
the memory image is loaded?

Alan Stern


--===============77483527032066957==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77483527032066957==--
