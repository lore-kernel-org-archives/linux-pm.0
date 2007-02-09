From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on SCSI and freezing
Date: Fri, 9 Feb 2007 13:09:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0702091307590.4548-100000@iolanthe.rowland.org>
References: <200702091648.14707.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702091648.14707.oliver@neukum.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 9 Feb 2007, Oliver Neukum wrote:

> Hi,
> =

> can the SCSI error handlers run while the system is frozen?

drivers/scsi/scsi_error.c doesn't include the word "freeze", so I'd say =

they can.

Alan Stern
