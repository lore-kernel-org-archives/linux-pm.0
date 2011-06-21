From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM / Runtime: Handle clocks correctly if
 CONFIG_PM_RUNTIME is unset
Date: Tue, 21 Jun 2011 16:10:44 +0900
Message-ID: <BANLkTin0dq07rquuAmE-jE1nmkRnKH7aSA__42907.4282212698$1308640303$gmane$org@mail.gmail.com>
References: <201106210128.52101.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106210128.52101.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 21, 2011 at 8:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Commit 85eb8c8d0b0900c073b0e6f89979ac9c439ade1a (PM / Runtime:
> Generic clock manipulation rountines for runtime PM (v6)) converted
> the shmobile platform to using generic code for runtime PM clock
> management, but it changed the behavior for CONFIG_PM_RUNTIME unset
> incorrectly.
>
> Specifically, for CONFIG_PM_RUNTIME unset pm_runtime_clk_notify()
> should enable clocks for action equal to BUS_NOTIFY_BIND_DRIVER and
> it should disable them for action equal to BUS_NOTIFY_UNBOUND_DRIVER
> (instead of BUS_NOTIFY_ADD_DEVICE and BUS_NOTIFY_DEL_DEVICE,
> respectively). =A0Make this function behave as appropriate.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks Rafael!

Acked-by: Magnus Damm <damm@opensource.se>
