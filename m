From: Oliver Neukum <oliver@neukum.org>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 09:00:44 +0100
Message-ID: <200712080900.45623.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>
	<20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
> FWIW the appended patch removes that rude "order of registration"
> policy, so that the suspend/resume list matches the device tree.
> It's behaved OK on PCs and, in light duty, a few development boards;
> I've carried it around most of this year.

As it is a tree, why not store it as such?

	Regards
		Oliver
