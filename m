From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Fri, 10 Jan 2014 09:46:14 -0500
Message-ID: <52D007B6.5020805@ubuntu.com>
References: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org> <3652290.QccRAxIbQ5@vostro.rjw.lan> <52CF52FA.3030001@ubuntu.com> <2073478.g5B0SjSvHB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:43539 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaAJOqP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 09:46:15 -0500
In-Reply-To: <2073478.g5B0SjSvHB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/10/2014 8:35 AM, Rafael J. Wysocki wrote:
> Well, thanks for reminding me how my code works. ;-)
> 
> .resume_early() runs with runtime PM disabled.

Ahh, then in that case we're back to not wanting to block the resume
path on disk_is_spinning().



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS0Ae2AAoJEI5FoCIzSKrwiqcH/jaoQ9WtE124xT53OaD7XfZQ
C45ftL7iZG/8iF/oW48RaEa8l87yoisThDjdokuMqo6SEkxsxAegg+l9yz98tSoX
kTj3x7rE8wPAwC4JCq7+6Xu2XTiK9ujHmohwJNljsqIdhbuLo+Y4XWNrKUzag2WX
8rJbX7bPTfg0ijtOkYUHfpJyap1OkG007MIeH4qQ/vZVd8Pem3Oy1jLdyLtpUMB5
D5ebHo6IdJDJpxX2EDSyHsI5UKEDycH6VLkCz06RpeMBkL4jePzL76D//9qfw+Kc
RpOyoOFhYM5q2XeXRSjtPX4vrUe5EqdLfqYriIYiYjNNDqrirhsBDUQ5SdXr7zE=
=HLer
-----END PGP SIGNATURE-----
