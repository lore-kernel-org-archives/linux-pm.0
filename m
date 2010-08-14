From: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.35 Regression: Ages spent discarding blocks that
 weren't used!
Date: Sat, 14 Aug 2010 07:43:53 -0400
Message-ID: <20100814114353.GA7929__36913.2767933936$1281786312$gmane$org@infradead.org>
References: <4C58C528.4000606@tuxonice.net> <4C5960B0.7020003@teksavvy.com>
	<4C59DA16.4020500@tuxonice.net>
	<AANLkTik_PH-7T7OFtzaCtPbAHE6pqnYMUsjP25KtsRnR@mail.gmail.com>
	<4C5A59FC.1030304@tuxonice.net>
	<AANLkTi=NMHkKduZzsLiiYt3=w8++8epb5aGrqv7V3-vB@mail.gmail.com>
	<4C5B925A.5000409@tuxonice.net>
	<AANLkTinU24v6Mty54YL3gv3M5S+4jdN5vHD54KknchAG@mail.gmail.com>
	<20100813115424.GA24737@infradead.org>
	<AANLkTik5osZR12nZVVvJY7LimiUZtBdZcnDi4VYNXhwr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik5osZR12nZVVvJY7LimiUZtBdZcnDi4VYNXhwr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hugh Dickins <hughd@google.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Mark Lord <kernel@teksavvy.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 13, 2010 at 11:15:38AM -0700, Hugh Dickins wrote:
> However, I am still not quite sure that we can already make that
> change for 2.6.35 (-stable).  Can you reassure me on the question I
> raise above: if we issue a discard to a device with cache, wait for
> "completion", then issue a write into the area spanned by that
> discard, can we be certain that the write to backing store will not be
> reordered before the discard of backing store (unless the device is
> just broken)?  Without a  REQ_HARDBARRIER in the 2.6.35 scheme?  It
> seems a very reasonable assumption to me, but I'm learning not to
> depend upon reasonable assumptions here.  (By the way, it doesn't
> matter at all whether writes not spanned by the discard pass it or
> not.)

Neither the SCSI (SPC and SBC) make the cache part of the protocol
except for the commands to commit them to non-volatile storage, so
even when reordering the backing device write it must still not
reorder them vs notified completion.  That's nothing specific to
discard, e.g. when a write was notified as complete a new read must
come from the cache even if it hasn't been commited to the backing
device.  Now I can't guarantee that all cheap SSD firmware
implementations gets thus right for TRIM, but if one is really
that buggy we need to blacklist it.
