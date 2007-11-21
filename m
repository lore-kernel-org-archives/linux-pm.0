From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Freezer fixes for 2.6.24
Date: Wed, 21 Nov 2007 20:21:51 +0100
Message-ID: <200711212021.51968.rjw@sisk.pl>
References: <200711210244.37965.rjw@sisk.pl> <4743E38D.60205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4743E38D.60205@gmail.com>
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
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 of November 2007, Franck Bui-Huu wrote:
> Rafael J. Wysocki wrote:
> > The second one is intended to fix the APM emulation breakage caused before
> > 2.6.23, but unfortunately I can't test it.
> 
> Why not ?
> 
> Just hack Kconfig to be able to select this driver on x86 architecture
> and it should work fine, no ?

Well, I'm afraid I have no suitable userland here ...

> I'll give it a test today.

OK, thanks!

Rafael
