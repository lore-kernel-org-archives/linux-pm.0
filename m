From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 10:21:35 +0200
Message-ID: <200707241021.35573.oliver__16561.607286758$1185265252$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707231124590.3545-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707231124590.3545-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Montag 23 Juli 2007 schrieb Alan Stern:
> Now here's an idea which might work. =A0Can we require every caller of
> device_add() to hold some existing device's semaphore? =A0Normally it
> would be the semaphore of the new device's parent, but it could be a
> higher ancestor. =A0There even could be a single "root" semaphore for
> drivers registering a top-level device with no parent.

What prevents us from having a device addition semaphore?
Adding device is not critical to performance, is it?

	Regards
		Oliver
