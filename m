From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 0/2] Freezer fixes for 2.6.24
Date: Wed, 21 Nov 2007 08:51:41 +0100
Message-ID: <4743E38D.60205@gmail.com>
References: <200711210244.37965.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711210244.37965.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> The second one is intended to fix the APM emulation breakage caused before
> 2.6.23, but unfortunately I can't test it.

Why not ?

Just hack Kconfig to be able to select this driver on x86 architecture
and it should work fine, no ?

I'll give it a test today.

		Franck
