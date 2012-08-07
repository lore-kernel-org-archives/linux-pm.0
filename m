From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Tue, 07 Aug 2012 15:19:47 +0200
Message-ID: <1344345590.3975.1.camel@thorin>
References: <50201156.30704@pavlinux.ru>
	<Pine.LNX.4.44L0.1208061556010.1649-100000@iolanthe.rowland.org>
	<5A9BC72FD5CEC94EA024CED8E31D701A2FD84FC0@wdscexmb03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5A9BC72FD5CEC94EA024CED8E31D701A2FD84FC0@wdscexmb03.sc.wdc.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Taylor <Daniel.Taylor@wdc.com>
Cc: Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Pavel Vasilyev <pavel@pavlinux.ru>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2012-08-06 at 22:57 +0000, Daniel Taylor wrote:
> Silly question:  when did sizeof("string") get changed to be anything
> other than the size of the pointer ("string" is, after all, an array
> of characters)? 

It is since K&R times that way.
If you do not know the difference between a pointer and an array (and
these are vastly different), go learn something new about C.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
