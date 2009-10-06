From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Massive ext4 filesystem corruption after a failed
	s2disk/ram cycle
Date: Wed, 7 Oct 2009 01:02:47 +0200
Message-ID: <200910070102.47293.rjw@sisk.pl>
References: <1254863215.11577.23.camel@maxim-laptop>
	<200910062358.32417.rjw@sisk.pl>
	<20091006225329.GA27646@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091006225329.GA27646@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 October 2009, Henrique de Moraes Holschuh wrote:
> On Tue, 06 Oct 2009, Rafael J. Wysocki wrote:
> > > You do sync file-systems before entering the hibernation, don't you?
> > 
> > Yes, a sync is there, but it is not effective on some filesystems.
> 
> Which ones?

XFS for one example.
