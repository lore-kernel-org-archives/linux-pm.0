Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C76286A5;
	Thu,  8 Oct 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482545; cv=none; b=SNcJUEq4o35+E00zcIVHMWzB6xUOw8z4IdgIRHLPn+/OowDvxIRxvrU09ejWZunH8f7Q5RmVvB4IPJNC8nMtl6la50mMNXeBFmDDRxu0rjqTSeB3vyCVsPEmXkqW6YNQqK4DQFBWgr713vOj+snRRBJCGjB4JruBeC/6+ZSQjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482545; c=relaxed/simple;
	bh=O8I5jlD0ZayOrZi/2iU0tko7bdUU1Pb0JowlOLL7Vok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGG3f+wskOjNSjRbdTmWOx9DHqqeVMaKO369sy6GfNBtbPh2oX/4YabdPUcucEfnw7LDUNOiYeV1Nw2HhIcn0D0UeXkghWSRS6DP7JpNzvg2TD0ERsdrTGCk7Eg2vBqO+++OuQg90KNkfYmAC+Joi5X1iYXpwd+K/qKn37kUSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqmrVjr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqmrVjr3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 47CAF1F000FF;
	Thu,  8 Oct 2026 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482543;
	bh=O0NcpkHnK83xXiiTwODz2XUl2fYuSE9a4VdVR5CoSMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EqmrVjr3ecLc4z0cc1OVN73DZprcrB9m1BKXRQoxvxnxuNVfhM8d7HQcl55XvXxc/
	 LSilUFauADO6ks/rNAO8QO8OsngK/LXarYJiAfqN+XFjxg/rxsC8TNOU6KJBA8RBmZ
	 RZDEsaGZu76FSEG3gQuSv07m3iZj+z9MmagD7KDz6jTEEdqbf+t0zNDHsBF0ycwDPE
	 +JVVZms22tXeMJVt8JM301eOglpvo2ILWwCqm3KnZINLIGXUCl3QdhhbOcfGD3KRqE
	 anA+94h8hR+vju+R+vTWLSFDK+5DB+dDI8C04i7/zWf3cCC1Lm1evhp0Gl5xxC6rna
	 3kBe8+nefc9ow==
Date: Thu, 8 Oct 2026 21:02:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Ramos <capitain_jack@yahoo.com>
Cc: Jhon Taylor Forbes =?iso-8859-1?Q?Ca=F1izares?= <hermanojhonforbes@hotmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
	ebiggers@kernel.org, rafael@kernel.org
Subject: Re: [RFC] power/hibernate: TPM2 image encryption to allow
 hibernation under lockdown
Message-ID: <asfarOdfsZbThUet@kernel.org>
References: <acHPLiT4lZdTp0wD@srcf.ucam.org>
 <179146953927.3470668.11045077335347628577@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179146953927.3470668.11045077335347628577@yahoo.com>

On Thu, Oct 08, 2026 at 11:25:39AM -0300, Daniel Ramos wrote:
> Hi Jhon, hi Matthew,
> 
> Jhon, thank you for starting this.
> I build Sparky Stereo OS, a SparkyLinux edition, and we want Secure Boot
> and hibernation together, so we ran your RFC through a small test bench
> on 7.3-rc6: QEMU with OVMF and Secure Boot, swtpm as the TPM 2.0, a
> scripted hibernate and resume, and tamper checks.
> Here is what we measured, in case it helps the next version.
> 
> The patch does not apply as posted (git apply reports a corrupt patch at
> line 59; the hunk line counts do not match their bodies), and the
> lockdown hunk breaks the build even with the option off: the enum is
> LOCKDOWN_HIBERNATION, and snapenc_is_active() is declared nowhere.
> With 17 small fixes it builds and boots. Sealing and unsealing could not
> be mapped to the in-tree API (tpm2_seal_trusted() needs a parent key and
> a PolicyPCR digest that nothing in the tree computes), so we stubbed
> them for the run.
> Under lockdown=confidentiality hibernation is then allowed, but on the
> default LZO path the image is written in plaintext while the kernel logs
> that it is encrypted: the hooks are only in save_image() and
> load_image(), the nocompress path.
> With hibernate=nocompress the kernel oopses while saving, because the
> AEAD associated data are not in the scatterlists.
> With those chained, the image is still plaintext (the ciphertext buffer
> is never written), and resume crashes because the decryption context
> exists only in the memory of the kernel being replaced.
> A tampered image is caught only by the existing CRC32 and LZO checks,
> and a change of PCR 23 between the boots is not noticed.
> 
> The detailed logs and the fixes are available if they help, and the
> bench can run any later version unchanged, including a design built on
> the requirements Matthew described:
> https://github.com/Sparky-OS/sparky-stereo-os/tree/main/tools/hibernate-bench
> Disclosure: the measurements were made with AI assistance (Claude),
> directed and checked by me.
> 
> Daniel Ramos

Can you describe roughly how this is setup in your environment? I cannot
use Spark OS (or any other distro) for kernel testing but a description
would get me up on speed once I have bandwidth.

Just trying to save a bit of my bandwidth, that's all.

Br, Jarkko
