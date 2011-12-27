From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] PM / Hibernate: Improve performance of
 LZO/plain hibernation, checksum image
Date: Tue, 27 Dec 2011 20:27:05 +0800
Message-ID: <CAGsJ_4yXU62GZ38fe7TCH8uKLHJvZ8jtFbJLywqv1kgC7y9V_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bojan@rexursive.com, rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
List-Id: linux-pm@vger.kernel.org

> Use threads for LZO compression/decompression on hibernate/thaw.
> Improve buffering on hibernate/thaw.
> Calculate/verify CRC32 of the image pages on hibernate/thaw.

> In my testing, this improved write/read speed by a factor of about two.

> Signed-off-by: Bojan Smojver <bojan@rexursive.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

hi Bojan,
this patch is definitely great!
any plan to write the same patch for decompress and restore? i think
that is probably more important than compression and hibernation to
improve bootup speed.

Thanks
barry
