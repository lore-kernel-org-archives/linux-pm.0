From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] block: always requeue !fs requests at the front
Date: Sun, 17 Jun 2007 17:03:23 +0900
Message-ID: <4674EACB.90509@gmail.com>
References: <200706020122.49989.rjw@sisk.pl> <46706968.7000703@dgreaves.com> <alpine.LFD.0.98.0706131507360.14121@woody.linux-foundation.org> <200706140115.58733.rjw@sisk.pl> <46714ECF.8080203@gmail.com> <46715A66.8030806@suse.de> <20070615094246.GN29122@htj.dyndns.org> <20070615110544.GR6149@kernel.dk> <20070616195401.GA6929@infradead.org> <20070617072957.GJ6149@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757366AbXFQIE6@vger.kernel.org>
In-Reply-To: <20070617072957.GJ6149@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Greaves <david@dgreaves.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Jens Axboe wrote:
>> I'd much much prefer having a description of the problem in the actual
>> comment then a hyperlink.  There's just too much chance of the latter
>> breaking over time, and it's impossible to update it when things change
>> that should be reflected in the comment.
> 
> The actual commit text is very good though, but I agree - I don't think
> the url comment is worth anything. I did consider just killing it.
> However, the comment does describe the problem, so I think it's still
> ok.

I thought the whole story was too long for the comment.  Feel free to
kill or edit it.

-- 
tejun
