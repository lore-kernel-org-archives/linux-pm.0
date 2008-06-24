From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 4/9] ACPI: Introduce
	acpi_device_sleep_wake function
Date: Tue, 24 Jun 2008 14:38:53 +0200
Message-ID: <20080624123852.GF5642__29187.6419251368$1214468867$gmane$org@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200149.31090.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806200149.31090.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-06-20 01:49:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI: Introduce acpi_device_sleep_wake function
> 
> The currect ACPI code attempts to execute _PSW at three different
> places and in one of them only it tries to execute _DSW before _PSW,
> which is inconsistent with the other two cases.
> 
> Move the execution of _DSW and _PSW into a separate function called
> acpi_device_sleep_wake() and call it wherever appropriate instead of
> executing _DSW and/or _PSW directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
